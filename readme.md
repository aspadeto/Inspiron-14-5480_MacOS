# 1. INTRODUÇÃO

  Instalando e utilizando o MacOS Mojave (10.14) em um Dell Inspiron 14 5480.

## Especificação do Equipamento
  - Dell Inspiron 14 5480 A20S
    - Intel i7-8565U
    - 8GB RAM
    - Display FullHD
    - Disco Rígido de 1TB
    - SSD M.2 Nvme Crucial 500GB (instalado após a compra)
    - BIOS versão: 2.2.0
    - Áudio Realtek ALC236
    - Interface de Rede Sem Fio Intel Wireless AC9462
    - Interface de Rede Ethernet Realtek RTL810xE FE
  - Mac OS Mojave 10.14.5
  - Windows 10 64bits
  - Os dois SOs estão instalados no mesmo disco.
  - Clover v2.4k r4961

## O que funciona?
  * Quase tudo, exceto o que está listado nos tópicos a seguir.

## Incompatibilidades
  * Interface de Rede Wifi e Bluetooth Intel AC9462 não compatível
  * Interface Gráfica Dedicada MX150 não é compatível

## Pendências
  * Mover as Kexts para a pastas /Library/Extensions

  * Quando o equipamento dorme as portas USB desligam e não voltam.

  * Conferir plug do áudio e se esse patch é necessário
    com.apple.driver.AppleMikeyDriver (MikeyDriver Patch Assertions)

  * Conferir no AppleALC se o patch abaixo é necessário
    com.apple.driver.AppleHDA (AppleHDA Patch Assertions)

# 2. INSTALAÇÃO

## Configuração da BIOS

- "VT-d" (virtualization for directed i/o) should be disabled if possible (the config.plist includes dart=0 in case you can't do this)
- "DEP" (data execution prevention) should be enabled for OS X
- "secure boot " should be disabled
- "legacy boot" optional (recommend enabled, but boot UEFI if you have it)
- "CSM" (compatibility support module) enabled or disabled (varies) (recommend enabled, but boot UEFI)
- "fast boot" (if available) should be disabled.
- "boot from USB" or "boot from external" enabled
- SATA mode (if available) should be AHCI
- TPM should be disabled

## Criando o Disco de Instalação

Tutorial completo (em inglês) aqui.
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

### Preparando a mídia,

  Faça download do Mojave na loja da Apple (se ainda não fez), após o download cancele a instalação forçando o fechamento.

  Então inicie um Terminal e execute o comando.

  ```
  sudo "/Applications/Install macOS Mojave.app/Contents/Resources/createinstallmedia" --volume  /Volumes/install_osx --nointeraction
  ```
  renomeie o disco para um nome mais acessível

  ```
  sudo diskutil rename "Install macOS Mojave" install_osx
  ```

## Clover

Considerando os arquivos e pastas disponíveis nesse repositório, copie as pastas EFI/Boot e  EFI/CLOVER para a pasta EFI da partição EFI da mídia de instalação.

Você pode fazer download do CLOVER mais atual e instalá-lo na partição EFI, fica a seu critério, de qualquer forma é ideal que se faça esse procedimento de atualização na partição EFI do sistema de destino, mas faremos isso no final.

## Pós Instalação

### Update do Clover


### Ajuste do horário no Windows

https://www.tonymacx86.com/threads/fix-incorrect-time-in-windows-osx-dual-boot.133719/

### Configurando SMBIOS

Open config.plist from attached CLOVER folder in CloverConfigurator
Clover Configurator (Global Edition)
and generate a new SMbios (use drop up/down menu just under the big ?)


### Esconder opções desnecessárias no CLOVER
  Pegar vídeo da russa, que não é russa

### Aplicando Temas ao Clover

Baixe o CloverThemeManager e modifique o tema do bootloader.

https://sourceforge.net/p/cloverefiboot/themes/ci/master/tree/CloverThemeManagerApp/Updates/

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

  3. Compile, aplique e reinicie o computador

    1. Compilando

      ```
      iasl DSDT.dsl
      ```

      Observe que o comando deve retornar "Compilation complete. 0 Errors".

    2. Copie o arquivo resultante para a pasta EFI/CLOVER/ACPI/patched

    3. Reinicie o equipamento

### Backup dos arquivos DSDT SSDT para cada alteração abaixo

  Uma boa estratégia é ir fazendo cópias dos arquivos que estão sendo alterados,
  isso vai facilitar o processo caso seja necessário repetir ou alterar alguma etapa.
  Assim você não precisar começar do zero.

### Desabilitando a Interface Gráfica Dedicada MX150

  Não há necessidade de manter a interface gráfica dedicada funcionando pois ela não funciona no MacOS, pra piorar ela fica gasta energia e ainda mantém a ventoinha funcionando, provocando barulho. Para isso foi adicionado o patch SSDT-DisableDGPU.aml em EFI/CLOVER/ACPI/patched.

  VEN 10DE DEV 1D10

  PCIROOT 0, PCI 1C04, PCI 0000
  ACPI(SB), ACPI(PCI0), RP5, PEGP

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

  3. Compile, aplique o DSDT e reinicie o equipamento.

  4. Instale os Kexts do VoodooI2C na pasta EFI/CLOVER/kext/other

    * VoodooI2C.kext,
    * VoodooI2CHID.kext

  5. Reinicie o equipamento

    A partir daí o trackpad deve estar 100% funcional.
    Vá até a configuração do sistema e acesse os painéis de preferências Trackpad e Acessibilidade para realizar os ajustes necessários.

## CONFIGURAÇÕES CLOVER

O arquivo config.plist utilizado tem como base o arquivo **config_HD615_620_630_640_650.plist** do repositório https://github.com/RehabMan/OS-X-Clover-Laptop-Config

### Configuração da Interface Gráfica Integrada Intel UHD 620

  ```
  <key>Properties</key>
  <dict>
    <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
    <dict>
      <key>AAPL,GfxYTile</key>
      <data>
      AQAAAA==
      </data>
      <key>AAPL,ig-platform-id</key>
      <data>
      AACbPg==
      </data>
      <key>device-id</key>
      <data>
      mz4AAA==
      </data>
      <key>disable-external-gpu</key>
      <data>
      AQAAAA==
      </data>
      <key>framebuffer-fbmem</key>
      <data>
      AACQAA==
      </data>
      <key>framebuffer-patch-enable</key>
      <data>
      AQAAAA==
      </data>
      <key>framebuffer-stolenmem</key>
      <data>
      AAAwAQ==
      </data>
      <key>framebuffer-unifiedmem</key>
      <data>
      AAAAgA==
      </data>
      <key>hda-gfx</key>
      <string>onboard-1</string>
      <key>model</key>
      <string>UHD Graphics 620 (Whiskey Lake)</string>
    </dict>
  </dict>
  ```

### Configuração do Áudio

  Device \ Audio \ Inject = 11

https://github.com/acidanthera/AppleALC/wiki/Supported-codecs

### Boot Arguments

  * dart = 0, detabilita o VT-d apenas para o MacOS caso queira deixar a opção habilitada na BIOS
  * debug=0x100, evita que o sistema reboot em caso de kernel panic
  * agdpmod=vit9696, agdpmod=vit9696 disables check for board-id (TODO: TESTAR)

# 4. TESTES FINAIS

## Verificar se o powermanagement está funcionando?

  https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/

  https://software.intel.com/en-us/articles/intel-power-gadget

## Geekbench 4

  * Geekbench 4 CPU:

  * Geekbench 4 PC:



# Referências

https://www.tonymacx86.com/threads/guide-dell-xps-9350-mojave-virtualsmc-i2c-trackpad-clover-uefi-hotpatch.267161/










** CONFERÊNCIA DO CLOVER

*** com.apple.driver.AppleAHCIPort (External icons patch)
Tem que ter

*** com.apple.driver.AppleGraphicsDevicePolicy (Prevent AGDP from loading)
Talvez seja necessário por conta de ter a interface gráfica dedicada

*** Patch kernel for having a full processor cores
config.plist/KernelAndKextPatches/KernelLapic=true.
