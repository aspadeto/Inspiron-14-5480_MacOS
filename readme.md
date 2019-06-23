# 1. INTRODUÇÃO

  Instalando e utilizando o MacOS Mojave (10.14) em um Dell Inspiron 14 5480.

## Especificação do Equipamento
  - Dell Inspiron 14 5480 A20S
    - Intel i7-8565U
    - 8GB RAM
    - Display FullHD
    - Disco Rígido de 1TB
    - SSD M.2 Nvme Crucial 500GB (instalado após a compra)
    - Versão da BIOS: 2.2.0

## O que funciona?
  * Quase tudo, exceto o que está listado nos tópicos a seguir.

## Incompatibilidades
  * Interface de Rede Wifi e Bluetooth (Intel XXX) não compatível
  * Interface Gráfica Dedicada MX150 não é compatível

## Pendências
  * Mover as Kexts para a pastas /Library/Extensions

  * Quando o equipamento dorme as portas USB desligam e não voltam.

  * Conferir plug do áudio e se esse patch é necessário
    com.apple.driver.AppleMikeyDriver (MikeyDriver Patch Assertions)

  * Conferir no AppleALC se o patch abaixo é necessário
    com.apple.driver.AppleHDA (AppleHDA Patch Assertions)

# 2. INSTALAÇÃO

## Criando o Disco de Instalação

  TODO

## Instalando

  Se o instalador não iniciar utilize o config-7mb.plist no CLOVER



  Bom, aqui termina o processo de instalação, a partir daqui você deve ter um sistema pronto para utilizar.

  Caso você tenha problemas ou deseje saber como tudo isso foi feito siga para o próximo capítulo.

# 3. CONFIGURAÇÃO

## Kexts utilizados

  * **Lilu.kext**

    Necessária para realizar o patch de várias funcionalidades necessárias para o funcionamento do Mac OS num PC comum.
    https://github.com/acidanthera/Lilu/releases

  * **VirtualSMC.kext, SMCBatteryManager.kext, SMCLightSensor.kext, SMCProcessor.kext, SMCSuperIO.kext**

    Necessária para emulação de várias funções de baixo nível do Mac OS nos equipamentos Intel. Substitui a FakeSMC.kext. Necessitada da Lilu.kext.
    https://github.com/acidanthera/VirtualSMC

  * **AppleALC**

    Para o funcionamento da interface de áudio. Depende da Lilu.kext.
    https://github.com/acidanthera/AppleALC/releases

  * **WhateverGreen.kext**

    Para o funcionamento da interface gráfica integrada Intel UHD 620. Depende da Lilu.kext.
    https://github.com/acidanthera/WhateverGreen/releases

  * **RealtekRTL8100.kext**

    Para a interface de rede Realtek.
    https://github.com/alexandred/VoodooI2C

  * **VoodooI2C.kext e VoodooI2CHID.kext**

    Para funcionamento do trackpad (com gestos)
    https://github.com/alexandred/VoodooI2C

  * **VoodooPS2Controller.kext**

    Para funcionamento do teclado.

## PATCHES DSDT E SSDT

### Como fazer patch do DSDT / SSDT

  1. Iniciar o equipamento, na tela do Clover apertar F4 (talvez seja necessário apertar Fn + F4)

  Isso vai gerar os arquivos necessários na pasta EFI/CLOVER/ACPI/origin

  2. Tire uma cópia desses arquvos para outra pasta e selecione apenas os que iniciam com SSDT-\*.aml (SSDT-1.aml, por exemplo) e DSDT.aml, o restante pode ser descartado.

  3. Execute o comando a seguir para gerar os arquivos DSL necessários.

  > iasl -dl \*.aml

  Se aparecer "Disassembly completed" é porque deu certo.

  4. Pronto, agora basta abrir (com o MaciASL) os arquivos DSL e realizar os patches necessários.

### PATCH Básico do DSDT

O equipamento exigiu algumas correções básicas no DSDT, como explico a seguir.

  1. Código fonte com sintaxe incorreta

  Erro: unexpected PARSEOP_IF, expecting PARSEOP_CLOSE_PAREN or ','

  É necessário corrigir esse pedaço de código.

   ```
     If (LEqual (PM6H, One))
     {
         CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, ECRW)  // _RW_: Read-Write Status
         Store (Zero, ECRW (If (PM0H)
                 {
                     CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, F0LN)  // _LEN: Length
                     Store (Zero, F0LN)
                 }))
     }
   ```

   Para que fique desse jeito:

   ```
   If (LEqual (PM6H, One))
   {
       CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, ECRW)  // _RW_: Read-Write Status
       Store (Zero, ECRW)
   }
   If (PM0H)
   {
       CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, F0LN)  // _LEN: Length
       Store (Zero, F0LN)
   }
   ```

  2. Linhas com ZERO

  Erro: 6327, 6126, syntax error, unexpected PARSEOP_ZERO

  É necessário apagar as linhas ZERO **indicadas nas mensagens de erro**, como no exemplo a seguir. Não apague nada em outros lugares.

  ```
  Zero
  Zero
  Zero
  Zero
  Zero
  Zero
  Zero
  ```

  Pronto, a correção básica foi feita, agora podemos passar para o próximo passo.

### Backup dos arquivos DSDT SSDT para cada alteração abaixo

  Uma boa estratégia é ir fazendo cópias dos arquivos que estão sendo alterados,
  isso vai facilitar o processo caso seja necessário repetir ou alterar alguma etapa.
  Assim você não precisar começar do zero.

### Desabilitando a Interface Gráfica Dedicada MX150

  Não há necessidade de manter a interface gráfica dedicada funcionando pois ela não funciona no MacOS, pra piorar ela fica gasta energia e ainda mantém a ventoinha funcionando, provocando barulho. Para isso foi adicionado o patch SSDT-DisableDGPU.aml em EFI/CLOVER/ACPI/patched.

### Desabilitando a verificação de Trackpad PS2 do VooodooPS2Controller

  Como esse equipamento não possui trackpad PS2 foi adicionada o patch SSDT-DisableTrackpadProbe.aml em EFI/CLOVER/ACPI/patched.

### Configuração do Trackpad com Gestos com o VoodooI2C

  Será utilizado o VoodooI2C para funcionamento do TrackPad com Gestos, pois o VoodooPS2Controller.kext não funciona, porém, este vai ser necessário para o teclado, conforme veremos a seguir.

  1. Verifique se o repositório VoodooI2C DSDT Patch está adicionado ao MaciASL e, caso necessário, adicione-o.
     Abra o MaciASL, acesse Preferences, abra a aba Sources e então adicione o item.
     Nome: VoodooI2C, url: http://raw.github.com/alexandred/VoodooI2C-Patches/master

     Você pode obter maiores informações aqui: https://voodooi2c.github.io/#Installation/Installation

  2. Aplique os seguintes Patches:

    * VoodooI2C-Patches / Windows 10 Patch
      Esse patch depende da versão do Windows que veio instalada no seu equipamento. Se o patch para Windows 10 não funcionar, tente os outros.

    * VoodooI2C-Patches / GPIO Controller Enable [SKL+]

  3. Antes de aplicar o próximo patch é necessário gerar uma versão preliminar do DSDT e copiá-lo para a pasta EFI/CLOVER/ACPI/patched. Após a cópia deve-se reiniciar o equipamento.

  Para compilar e gerar o arquivo AML resultante deve-se utilizar novamente a ferramenta iasl

  > iasl DSDT.dsl

  Observe que o comando deve retornar "Compilation complete. 0 Errors".

  4. Após reiniciar o laptop, abra o aplicativo IORegistryExplorer e procure pelo dispositivo.

  No modo de visualização IODeviceTree, o dispositivo foi identificado em PCI0 \ I2C0 \ TPD0.

  Tome nota da propriedade IOInterruptSpecifiers = 33 00 00 00 03 00 00 00.

  5. Instale os Kexts do VoodooI2C na pasta EFI/CLOVER/kext/other

    * VoodooI2C.kext,
    * VoodooI2CHID.kext




### Configuração da Interface Gráfica Integrada Intel UHD 620





# 4. TESTES FINAIS

## Verificar se o powermanagement está funcionando?

  https://software.intel.com/en-us/articles/intel-power-gadget

## Geekbench 4

  * Geekbench 4 CPU:

  * Geekbench 4 PC:



# 5. PÓS INSTALAÇÃO

## Esconder opções desnecessárias no CLOVER
Pegar vídeo da russa.









** CONFERÊNCIA DO CLOVER

*** com.apple.driver.AppleAHCIPort (External icons patch)
Tem que ter

*** com.apple.driver.AppleGraphicsDevicePolicy (Prevent AGDP from loading)
Talvez seja necessário por conta de ter a interface gráfica dedicada

*** Patch kernel for having a full processor cores
config.plist/KernelAndKextPatches/KernelLapic=true.
