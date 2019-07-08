# 1. INTRODUÇÃO

  MacOS Mojave (10.14.5) no Dell Inspiron 14 5480.
  Esse não é bem um guia, apesar de utilizar Hackintoshs desde o Snow Leopard não tenho tanta experiência com hardwares variados, muito menos estou habilitado a tirar dúvidas sobre questões diversas. Esse documento está mais para review.

  Comprei esse equipamento especificamente para utilizar como hackintosh, ele está disponível atualmente (2019) no mercado brasileiro, tem boa construção e um ótimo custo/benefício, e, como o resultado da instalação do Mojave foi muito satisfatório, compartilho aqui as configurações aplicadas no equipamento.

## Especificação do Equipamento
  * Dell Inspiron 14 5480 A20S
    - Intel i7-8565U (Whiskey Lake);
    - 8GB RAM;
    - Display FullHD IPS Antirreflexo;
    - Disco Rígido de 1TB;
    - 2 USB 3.0, 1 USB 2.0, 1 USB Type-C (DisplayPort e Alimentação);
    - Leitor de cartão;
    - Saída para fone de ouvido;
    - Webcam;
    - SSD M.2 Nvme Crucial 500GB (instalado após a compra);
    - BIOS versão: 2.2.0;
    - Áudio Realtek ALC236;
    - Interface de Rede Sem Fio Intel Wireless AC9462;
    - Interface de Rede Ethernet Realtek RTL810xE FE;
    - Teclado retroiluminado.

## Softwares
  * Mac OS Mojave 10.14.5;
  * Clover v2.4k r4961;
  * Windows 10 64bits;

## O que funciona?
  * Intel UHD Graphics 620 com Quartz Extreme (QE/CI) e Metal;
  * Saída de vídeo e áudio através de HDMI;
  * Áudio interno e saída para fones;
  * Áudio através da HDMI;
  * Unidade de Armazenamento NVMe;
  * Webcam;
  * Rede Ethernet;
  * Sleep e Wake;
  * Trackpad com gestos;
  * Monitoramento de CPU, bateria, temperatura, etc;
  * Bateria com duração de aproximadamente 4h;
  * Regulagem de brilho no monitor Interno através do painel de configuração e do atalho no teclado (Fn+F11,F12);
  * Regulagem de volume através dos atalhos Fn+F1,F2,F3;
  * Atalhos de multimídia Fn+F4,F5 e F6 (anterior, play/pause, próximo);
  * Teclado retroiluminado;
  * Dual boot Mac OS Mojave 10.14.5 e Windows 10, os dois SOs estão instalados no mesmo disco.

## Problemas ou incompatibilidades
  * Interface de Rede Wifi da interface Intel AC9462 não compatível, o bluetooth é identificado, mas ainda não funcionou.
  * Interface Gráfica Dedicada MX150 não é compatível.

## TODO (pendências)
  * Quando o equipamento dorme as portas USB desligam e não voltam.
  * Ajustar a questão das portas USB para retirar o

# 2. INSTALAÇÃO

## Configuração da BIOS
  * SATA Operation: AHCI;
  * Drivers: todos;
  * SMART Reporting: Habilitado
  * USB Configuration:
    - Enable USB Boot Support: Sim;
    - Enable External USB Port: Sim.
  * Audio: tudo habilitado;
  * Miscellaneous Devices:
    - Enable Camera: Sim.
  * PTT: desabilitado;
  * Computrace: Dactivate;
  * SMM: desabilitado;
  * Secure Boot: desabilitado;
  * Secure Boot Mode: Deploy Mode;
  * Intel SGX: Software Controlled;
  * Performance:
    - Multi Core Support: habilitado;
    - Intel SpeedStep: habilitado;
    - C-States: habilitado;
    - TurboBoost: habilitado;
    - HT Control: habilitado;
  * Power Management:
    - Enable Intel Speed Shift Technology: habilitado;
    - USB Wake Support: desabilitado;
    - Block Sleep: desabilitado;
  * POST Behavior
    - Fastboot: Thorough
  * Virtualization Support
    - Viritualization, Enable Intel VT habilitado: habilitado;
    - "VT-d" (Virtualization for Direct I/O): desabilitar, ou incluir dart=0 nos argumentos de boot

## Instalação

Utilize a image Mojave do Olarila e o config2.plist.
https://olarila.com/forum/viewtopic.php?f=50&t=6257

Ou utilize algum outro tutorial, como esse aqui.
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

No geral, os processos de instalação são parecidos: baixar disco de instalação/imagem, instalar Clover, configurar alguma coisa no config.plist, instalar, etc. Caso haja dificuldade na instalação o ideal é perguntar no tópico específico.

Após a instalação é necessário realizar alguns ajustes, veja a seguir.  

## Pós Instalação

### Instalação do Clover no Disco de Boot

Faça a instalação do Clover no disco de boot do equipamento e depois copie a pasta EFI/CLOVER da mídia removível para a partição EFI do disco de boot.

### Ajuste do horário no Windows

https://www.tonymacx86.com/threads/fix-incorrect-time-in-windows-osx-dual-boot.133719/

### Configurando SMBIOS

Faça download do Clover Configurator, monte a undiade EFI do disco de boot, e então abra o config.plist da pasta CLOVER no CloverConfigurator.

No Clover Configurator vá em SMBIOS gere os dados dessa aba, use a caixa de seleção abaixo do sinal de interrogação.

https://mackie100projects.altervista.org/download/ccg/

### Aplicando Temas ao Clover

Baixe o CloverThemeManager e modifique o tema do bootloader.

https://sourceforge.net/p/cloverefiboot/themes/ci/master/tree/CloverThemeManagerApp/Updates/

# 3. CONFIGURAÇÃO

Aqui eu explico como

## Kexts utilizados

  * **Lilu.kext**

    Necessária para realizar o patch de várias funcionalidades necessárias para o funcionamento do Mac OS num PC comum.
    https://github.com/acidanthera/Lilu/releases

  * **VirtualSMC.kext, SMCBatteryManager.kext, SMCLightSensor.kext, SMCProcessor.kext, SMCSuperIO.kext**

    Necessária para emulação de várias funções de baixo nível do Mac OS nos equipamentos Intel. Substitui a FakeSMC.kext.
    https://github.com/acidanthera/VirtualSMC

  * **AppleALC**

    Para o funcionamento da interface de áudio.
    https://github.com/acidanthera/AppleALC/releases

  * **WhateverGreen.kext**

    Para o funcionamento da interface gráfica integrada Intel UHD 620 e da porta HDMI.
    https://github.com/acidanthera/WhateverGreen/releases

  * **RealtekRTL8100.kext**

    Para a interface de rede Realtek.

  * **VoodooPS2Controller.kext**

    Para funcionamento do teclado e do trackpad.

  * **USBInjectAll.kext**

    Para funcionamento das portas USB.

  * **SATA-unsupported**

    Para que o Mac reconheça o chipset Intel 300 Series. Identifiquei uma leve melhora na performance.

  * **FakePCIID.kext** e **FakePCIID_Intel_HDMI_Audio.kext**

    Para o funcionamento do áudio através da porta HDMI

## PATCHES DSDT E SSDT

https://sourceforge.net/p/maciasl/wiki/Home/

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

* Configurações parecidas
https://www.tonymacx86.com/threads/guide-dell-xps-9350-mojave-virtualsmc-i2c-trackpad-clover-uefi-hotpatch.267161/

* AppleGraphicsDevicePolicy, Prevent AGDP from Loading
https://www.elitemacx86.com/threads/fix-black-screen-issue-with-macpro-6-1-and-imac-15-17-system-definition-nvidia-amd.212/

* AppleMikeyDriver
https://olarila.com/forum/viewtopic.php?f=50&t=6254&p=56325&hilit=applemikeydriver#p56325

* CsrActiveConfig = 0x3E7
https://www.reddit.com/r/hackintosh/comments/bt17xk/differences_between_0x67_and_0x3e7/

* com.apple.driver.AppleAHCIPort (External icons patch)
https://hackintosher.com/forums/thread/nvme-shows-as-external.339/

* SATA-unsupported

https://www.tonymacx86.com/threads/guide-dell-inspiron-7560-mojave-installation.261827/

*

*** com.apple.driver.AppleGraphicsDevicePolicy (Prevent AGDP from loading)
Talvez seja necessário por conta de ter a interface gráfica dedicada

*** Patch kernel for having a full processor cores
config.plist/KernelAndKextPatches/KernelLapic=true.
