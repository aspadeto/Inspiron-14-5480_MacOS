# 1. INTRODUÇÃO

  Apresento a seguir a experiência exitosa de utilização do macOS Mojave no Dell Inspiron 14 5480 A20s.

  O repositório https://github.com/aspadeto/Inspiron-14-5480_MacOS traz todo conteúdo utilizado nesse guia e maiores detalhes sobre a configuração.

  Comprei esse equipamento especificamente para utilizar como hackintosh, ele está disponível atualmente (em 2019) no mercado brasileiro e tem um ótimo custo/benefício.

  Como o resultado da instalação do Mojave foi muito satisfatório compartilho aqui as configurações aplicadas no equipamento.

## 1.1 Especificação do Equipamento
  * Dell Inspiron 14 5480 A20S
    - Intel i7-8565U (Whiskey Lake);
    - 8GB RAM;
    - Display FullHD IPS Antirreflexo;
    - Disco Rígido de 1TB;
    - 2 USB 3.0, 1 USB 2.0, 1 USB Type-C (DisplayPort e Alimentação);
    - Leitor de cartão;
    - Saída para fone de ouvido;
    - Webcam;
    - BIOS versão: ~~2.2.0~~ ~~2.4.0~~ 2.8.0 (Bios foi atualizada, isso exigiu a realização do patch DSDT novamente);
    - Áudio Realtek ALC236;
    - Interface de Rede Sem Fio Intel Wireless AC9462;
    - Interface de Rede Ethernet Realtek RTL810xE FE;
    - Teclado retroiluminado.
  * Extras (adicionados posteriormente)
    - SSD M.2 Nvme Crucial 500GB;
    - Dell DW1560 Broadcom BCM94352Z Rede sem fio + Bluetooth 4.0 comprada no Aliexpress.
    - 16GB Crucial DDR4 2666 (funcionando em 2400), totalizando 24GB de RAM.
  * Softwares
    - Mac OS Mojave 10.14.6 (inicialmente foi instalado no 10.14.5);
    - Clover (v2.4k r4961, 2.5 5103, 5122);
    - Windows 10 64bits;

[Sobre este Macbook](https://github.com/aspadeto/Inspiron-14-5480_MacOS/blob/master/imgs/about-this-mac.png?raw=true)

## 1.2 O que funciona?

  * Hardware
    * Intel UHD Graphics 620 com Quartz Extreme (QE/CI) e Metal;
    * Saída de vídeo e áudio através de HDMI;
    * Áudio interno e saída para fones;
    * Unidade de Armazenamento NVMe;
    * Webcam;
    * Rede Ethernet;
    * Wifi e Bluetooth através da DW1560;
    * Trackpad com gestos;
    * Regulagem de brilho no monitor Interno através do painel de configuração e do atalho no teclado (Fn+F11,F12);
    * Regulagem de volume através dos atalhos Fn+F1,F2,F3;
    * Atalhos de multimídia Fn+F4,F5 e F6 (anterior, play/pause, próximo);
    * Teclado retroiluminado com regulagem de brilho.
  * Funcionalidades:
    * Sleep e Wake;
    * Monitoramento de CPU, bateria, temperatura, etc;
    * Bateria com duração de aproximadamente 4h;
    * Dual boot OSx-Windows, os dois SOs dividem a mesma unidade de armazenamento.
    * A porta USB Type-C testada: funciona inclusive para carregamento do laptop;

## 1.3 Problemas ou incompatibilidades
  * ~~Interface de Rede Wifi da interface Intel AC9462 não compatível, o bluetooth é identificado, mas ainda não funcionou.~~. Interface foi substituída pela DW1560.
  * Interface Gráfica Dedicada MX150 não é compatível.
  * Leitor de cartão de memória não é compatível.

# 2. INSTALAÇÃO

## 2.1 Configuração da BIOS
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

## 2.2 Instalação do Sistema Operacional macOS Mojave

Utilize a image Mojave do Olarila e o config2.plist.
https://olarila.com/forum/viewtopic.php?f=50&t=8685

Ou utilize algum outro tutorial, como esse aqui.
https://www.tonymacx86.com/threads/guide-booting-the-os-x-installer-on-laptops-with-clover.148093/

Após a instalação é necessário realizar alguns ajustes, veja a seguir.  

# 3. PÓS INTALAÇÃO

## 3.1 Instalação do Clover no Disco de Boot

Faça a instalação do Clover no disco de boot do equipamento e depois copie a pasta EFI/CLOVER da mídia removível para a partição EFI do disco de boot.

## 3.2 Ajuste do horário no Windows

https://www.tonymacx86.com/threads/fix-incorrect-time-in-windows-osx-dual-boot.133719/

## 3.3 Configurando SMBIOS

Faça download do Clover Configurator (https://mackie100projects.altervista.org/download/ccg/), monte a undiade EFI do disco de boot, e então abra o config.plist da pasta CLOVER no CloverConfigurator.

No Clover Configurator vá em SMBIOS gere os dados dessa aba, use a caixa de seleção abaixo do sinal de interrogação.

## 3.4 Aplicando Temas ao Clover

https://github.com/CloverHackyColor/CloverThemes

## 3.5 Cópia dos Kexts para a pasta /Library/Extensions

Após tudo estar funcionando da forma correta o ideal é mover as kexts da pasta /EFI/Clover/kexts/Other para a pasta /Library/Extensions

Para facilitar essa tarefa você pode utilizar a ferramenta Hackintool (https://www.tonymacx86.com/threads/release-hackintool-v2-7-1.254559/), que além de ajudar na movimentação dos arquivos também oferece uma ferramenta para fazer rebuild do cache das kexts.

# 4. CONFIGURAÇÃO

Aqui eu explico quais configurações foram aplicadas no sistema e como essas configurações foram aplicadas.
Essa parte está aqui apenas para referência, todos estas configurações já estão disponíveis nos arquivos na pasta EFI deste repositório.

## 4.1 Kexts utilizados

  * **Lilu.kext**

    Necessária para realizar o patch de várias funcionalidades necessárias para o funcionamento do Mac OS num PC comum.
    https://github.com/acidanthera/Lilu/releases

  * **VirtualSMC.kext, SMCBatteryManager.kext, SMCLightSensor.kext, SMCProcessor.kext, SMCSuperIO.kext**

    Necessária para emulação de várias funções de baixo nível do Mac OS nos equipamentos Intel. Substitui a FakeSMC.kext.
    https://github.com/acidanthera/VirtualSMC

  * **AppleALC**

    Para o funcionamento da interface de áudio. (necessita das especificações em config.plist)
    https://github.com/acidanthera/AppleALC/releases

  * **WhateverGreen.kext**

    Para o funcionamento da interface gráfica integrada Intel UHD 620 e da porta HDMI.
    https://github.com/acidanthera/WhateverGreen/releases

  * **RealtekRTL8100.kext**

    Para a interface de rede Realtek.

  * **VoodooPS2Controller.kext**

    Para funcionamento do teclado ~~e do trackpad~~.
    Os plugins VoodooPS2Trackpad e VoodooPS2Mouse foram removidos para evitar conflito com o VoodooI2C.

  * **VoodooI2C.kext** e **VoodooI2CHID.kext**

    Para funcionamento do trackpad. (necessita das alterações no DSDT)

  * **USBInjectAll.kext**

    Para funcionamento das portas USB. (necessita do patch)

  * **SATA-unsupported**

    Para que o Mac reconheça o chipset Intel 300 Series. Identifiquei uma leve melhora na performance.

  * **FakePCIID.kext** e **FakePCIID_Intel_HDMI_Audio.kext**

    Para o funcionamento do áudio através da porta HDMI

  * **BrcmFirmwareRepo.kext**, **BrcmPatchRAM2.kext** e **AirportBrcmFixup.kext**

    Para o funcionamento da Wifi e da interface DW1560.

## 4.2 Patches para DSDT e SSDT

  Antes de começar faça download do MaciASL em https://sourceforge.net/p/maciasl/wiki/Home/.

### 4.2.1 Passos iniciais

  1. Iniciar o equipamento, na tela do Clover apertar F4 (talvez seja necessário apertar Fn + F4)

      Isso vai gerar os arquivos necessários na pasta EFI/CLOVER/ACPI/origin

  2. Tire uma cópia desses arquvos para outra pasta e selecione apenas os que iniciam com SSDT-\*.aml (SSDT-1.aml, por exemplo) e DSDT.aml, o restante pode ser descartado.
      > cp /Volumes/EFI/EFI/CLOVER/ACPI/origin/DSDT.aml .
      > cp /Volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-?.aml .

  3. Execute o comando a seguir para gerar os arquivos DSL necessários.
      > iasl -dl \*.aml

      Se aparecer "Disassembly completed" é porque deu certo.

  4. Pronto, agora basta abrir (com o MaciASL) os arquivos DSL e realizar os patches necessários.

### 4.2.2 Correções iniciais no DSDT

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

  3. Patches em GPI0 e TDP0 para o funcionamento do trackpad I2C

      Aplique os patches:

      ```
      into method label _STA parent_label GPI0 replace_content begin
        Return (0x0F)
      end;
      ```

      ```
      into method label _CRS parent_label TPD0 replace_content begin
        Return (ConcatenateResTemplate (SBFB, SBFG))
      end;
      ```

  4. Aplique o patch no SSDT-9.dsl

    Essa linha

      ```
      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
      ```
    deve ser substituída por essa

      ```
      Method (XDSM, 4, Serialized)  // _DSM: Device-Specific Methd
      ```

  5. Compile, aplique e reinicie o computador

     1. Compilando

        ```
        iasl DSDT.dsl
        ```

        Observe que o comando deve retornar "Compilation complete. 0 Errors".

        Compile os outros arquivos.

        ```
        iasl *.dsl
        ```

     2. Copie os arquivos resultantes (listagem abaixo) para a pasta EFI/CLOVER/ACPI/patched
        * DSDT.aml
        * SSDT-DisableDGPU.aml
        * SSDT-DiscreteSpoof.aml
        * SSDT-MCHC.aml
        * SSDT-TPD0.aml
        * SSDT-XOSI.aml
        * SSDT-ALC283.aml
        * SSDT-PNLFCFL.aml
        * SSDT-UIAC.aml
        * SSDT-BRT6.aml
        * SSDT-GPI0.aml
        * SSDT-RMDT.aml
        * SSDT-USBX.aml

        Eu prefiro copiar também os arquivos DSL correspondentes para a pasta patched mesmo que isso não interfira no resultado final para que quando houver uma atualização importante fique fácil de descobrir as diferenças e eu não precise baixar o código do repositório.

     3. Reinicie o equipamento

### 4.2.3 Patches SSDT e suas finalidades

  * **SSDT-DisableDGPU.aml e SSDT-DiscreteSpoof.aml**

    Ambos tentam fazer a mesma coisa, são duas extratégias diferentes de tentar desabilitar a interface gráfica dedicada.

    Não há necessidade de manter a interface gráfica dedicada ligada pois ela não funciona no MacOS, pra piorar ela fica gasta energia e ainda mantém a ventoinha funcionando, provocando barulho.

  * **SSDT-PNLFCFL.aml**

    Para funcionamento do ajuste do brilho do monitor

  * **SSDT-BRT6.aml**

    Para funcionamento dos atalhos Fn+F11 e Fn+F12 para ajuste do brilho do monitor.

  * **SSDT-MCHC.aml**

    Adds the missing Memory (DRAM) Controller to the system

  * **SSDT-RMDT.aml**

    Para funcionamento do ACPIDebug. Totalmente opicional.

    Veja mais informações aqui: https://github.com/RehabMan/OS-X-ACPI-Debug

  * **SSDT-XOSI.aml**

    Faz com que o sistema seja identificado como Darwin

  * **SSDT-USBX.aml** e **SSDT-UIAC.aml**

    Configura as portas USB do equipamento. É necessário a USBInjectAll.kext.

  * **SSDT-GPI0.aml e SSDT-TPD0.aml**
    Para o correto funcionamento do trackpad com o VoodooI2C.kext

## 4.3 CONFIGURAÇÕES CLOVER

O arquivo config.plist utilizado tem como base o arquivo **config_HD615_620_630_640_650.plist** do repositório https://github.com/RehabMan/OS-X-Clover-Laptop-Config, mas muitas atualizações já foram feitas.

Entre várias configurações, destaco as seguintes.

### 4.3.1 Configuração da Interface Gráfica Integrada Intel UHD 620

  ```
        <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
  			<dict>
  				<key>framebuffer-unifiedmem</key>
  				<data>AAAAYA==</data>
  				<key>framebuffer-con1-type</key>
  				<data>AAgAAA==</data>
  				<key>framebuffer-stolenmem</key>
  				<data>AACQAw==</data>
  				<key>framebuffer-camellia</key>
  				<data>AwAAAA==</data>
  				<key>framebuffer-memorycount</key>
  				<data>AwAAAA==</data>
  				<key>enable-hdmi20</key>
  				<data>AQAAAA==</data>
  				<key>hda-gfx</key>
  				<string>onboard-1</string>
  				<key>framebuffer-mobile</key>
  				<data>AQAAAA==</data>
  				<key>framebuffer-con1-enable</key>
  				<data>AQAAAA==</data>
  				<key>device-id</key>
  				<data>pT4AAA==</data>
  				<key>framebuffer-con2-enable</key>
  				<data>AQAAAA==</data>
  				<key>AAPL,GfxYTile</key>
  				<data>AQAAAA==</data>
  				<key>framebuffer-pipecount</key>
  				<data>AwAAAA==</data>
  				<key>framebuffer-con2-type</key>
  				<data>AAQAAA==</data>
  				<key>model</key>
  				<string>UHD Graphics 620 (Whiskey Lake)</string>
  				<key>framebuffer-fbmem</key>
  				<data>AAAAAA==</data>
  				<key>AAPL,ig-platform-id</key>
  				<data>CQClPg==</data>
  				<key>framebuffer-portcount</key>
  				<data>AwAAAA==</data>
  				<key>AAPL,slot-name</key>
  				<string>Internal@0,2,0</string>
  				<key>device_type</key>
  				<string>VGA compatible controller</string>
  				<key>framebuffer-con1-busid</key>
  				<data>AQAAAA==</data>
  				<key>disable-external-gpu</key>
  				<data>AQAAAA==</data>
  				<key>framebuffer-patch-enable</key>
  				<data>AQAAAA==</data>
  			</dict>
  ```

  Para verificar como configurar os conectores da interface de vídeo veja o guia Acer Swift 5 SF514-53t whiskey lake MacOS10.14.5 na referências.


### 4.3.2 Configuração do Áudio

  ```
  <key>PciRoot(0x0)/Pci(0x1F,0x3)</key>
  <dict>
    <key>device-id</key>
    <data>cKEAAA==</data>
    <key>#model</key>
    <string>Cannon Point-LP High Definition Audio Controller</string>
    <key>layout-id</key>
    <data>EAAAAA==</data>
    <key>AAPL,slot-name</key>
    <string>Internal</string>
    <key>device_type</key>
    <string>Audio device</string>
  </dict>
  ```

  Veja mais aqui: https://github.com/acidanthera/AppleALC/wiki/Supported-codecs


### 4.3.4 Boot Arguments

  * dart = 0, detabilita o VT-d apenas para o MacOS caso queira deixar a opção habilitada na BIOS
  * debug=0x100, evita que o sistema reboot em caso de kernel panic
  * agdpmod=vit9696 disables check for board-id
  * -igfxblr para o brilho da tela funcionar após o reboot.
  * ver commits no arquivo config.plist

### 4.3.5 CsrActiveConfig

Fonte: https://www.elitemacx86.com/threads/guide-how-to-disable-sip-system-integrity-protection.260/

CsrActiveConfig values and their functions:

CsrActiveConfig=0x0​
SIP is fully enabled​
​
CsrActiveConfig=0x3​
SIP is partially disabled​
​
CsrActiveConfig=0x67​
SIP is fully disabled​

There are several other like 0x3E7 which eventually disables more protections than 0x67 but it’s not a good idea to disable all those protection measures which make macOS more vulnerable.


### 4.3.6 Outras configurações

  * config.plist/ACPI/SSDT/Generate/PluginType = marcado: Power Management (veja o resultado no utilitário Intel Power Gadget)
    https://www.tonymacx86.com/threads/macos-native-cpu-igpu-power-management.222982/

  * Muitas informações estão disponíveis aqui: https://sourceforge.net/p/cloverefiboot/wiki/Configuration/

### 4.4. Configuração para iCloud, Facetime e App Store

  https://www.tonymacx86.com/threads/how-to-fix-imessage.110471/

# 5. FERRAMENTAS UTILIZADAS

  * GenI2C
    Configuração do trackpad https://github.com/williambj1/GenI2C

  * Intel Power Gadgets
    https://software.intel.com/en-us/articles/intel-power-gadget

  * Clover Configurator
    https://www.tonymacx86.com/resources/clover-configurator.467/

  * Hackintool
    Canivete suíço do hackintosh
    https://github.com/headkaze/Hackintool

  * iMessageDebug
    https://www.tonymacx86.com/threads/how-to-fix-imessage.110471/

  * CloverThemeManager
    https://sourceforge.net/p/cloverefiboot/themes/ci/master/tree/CloverThemeManagerApp/Updates/

# 6. TESTES

## 6.1 Power management

[Intel Power Gadget](https://github.com/aspadeto/Inspiron-14-5480_MacOS/blob/master/imgs/intel-power-gadget.png?raw=true)

Ver os seguintes artigos.

  https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/

## 6.2 Resultados dos testes de performance

[Geekbench 4](https://github.com/aspadeto/Inspiron-14-5480_MacOS/blob/master/imgs/geekbench4-mojave.png?raw=true)

[Geekbench 5](https://github.com/aspadeto/Inspiron-14-5480_MacOS/blob/master/imgs/geekbench5-mojave.png?raw=true)

# 7. REFERÊNCIAS

* Configurações parecidas
  * https://www.tonymacx86.com/threads/guide-dell-xps-9350-mojave-virtualsmc-i2c-trackpad-clover-uefi-hotpatch.267161/

  * macOS Mojave on Dell XPS 9570 https://github.com/bavariancake/XPS9570-macOS

  * XPS15-9560-Mojave https://github.com/jardenliu/XPS15-9560-Mojave/

  * Acer Swift 5 SF514-53t whiskey lake MacOS10.14.5 https://www.tonymacx86.com/threads/guide-acer-swift-5-sf514-53t-whiskey-lake-macos10-14-5.277618/

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

* An iDiot's Guide To Lilu and its Plug-ins
https://www.tonymacx86.com/threads/an-idiots-guide-to-lilu-and-its-plug-ins.260063/

* Hackintool
https://www.tonymacx86.com/threads/release-hackintool-v2-7-1.254559/

* An iDiot's Guide To iMessage
https://www.tonymacx86.com/threads/an-idiots-guide-to-imessage.196827/

* Guide: How to Fix iMessage Version 2.1
https://www.tonymacx86.com/threads/how-to-fix-imessage.110471/

* A Beginner's Guide to Creating a Custom USB SSDT
https://www.tonymacx86.com/threads/a-beginners-guide-to-creating-a-custom-usb-ssdt.272505/

* Ajuste de DPI
https://github.com/xzhih/one-key-hidpi

* Custom SSDT para USBInjectAll
https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/

* Patching LAPTOP DSDT/SSDTs
https://www.tonymacx86.com/threads/guide-patching-laptop-dsdt-ssdts.152573/

* Patching DSDT/SSDT for LAPTOP backlight control
https://www.tonymacx86.com/threads/guide-patching-dsdt-ssdt-for-laptop-backlight-control.152659/

* Disabling discrete graphics in dual-GPU laptops
https://www.tonymacx86.com/threads/guide-disabling-discrete-graphics-in-dual-gpu-laptops.163772/

* Intel® Power Gadget
https://software.intel.com/en-us/articles/intel-power-gadget

* GPIO Pinning
https://voodooi2c.github.io/#GPIO%20Pinning/GPIO%20Pinning

* Clover EFI Bootloader - Understanding KextsToPatch HOW TO GUIDE
https://www.insanelymac.com/forum/topic/311512-clover-efi-bootloader-understanding-kextstopatch-how-to-guide/

* Improving Sleep on a Hackintosh (Wakeup, Freezes, Black Screens)
https://hackintosher.com/forums/thread/improving-sleep-on-a-hackintosh-wakeup-freezes-black-screens.486/

* A Guide on Fixing Sleep Issues
https://www.insanelymac.com/forum/topic/306737-a-guide-on-fixing-sleep-issues/

* DSDT/SSDT - Conhecimentos Gerais https://www.insanelymac.com/forum/topic/297771-guia-dsdtssdt-conhecimentos-gerais/

* DSDT/SSDT: Everything you need to know about SSDT
https://hackintoshlaptop.net/dsdtssdt-everything-you-need-to-know-about-ssdt/

* Broadcom WiFi/Bluetooth [Guide]
https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423/

* WhateverGreen Intel® HD Graphics FAQ
https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md

* Enable I2C Trackpad (VoodooI2C) - Not a Guide... not really
https://olarila.com/forum/viewtopic.php?t=8087
