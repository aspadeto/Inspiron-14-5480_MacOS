# 1. INTRODUÇÃO

  Apresento a seguir a experiência exitosa de utilização do macOS Mojave no Dell Inspiron 14 5480 A20s.

  O repositório https://github.com/aspadeto/Inspiron-14-5480_MacOS traz todo conteúdo utilizado nesse guia e maiores detalhes sobre a configuração.

  Comprei esse equipamento especificamente para utilizar como hackintosh, ele está disponível atualmente (2019) no mercado brasileiro e tem um ótimo custo/benefício.

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
    - BIOS versão: ~~2.2.0~~ 2.4.0 (Bios foi atualizada, isso exigiu a realização do patch DSDT novamente);
    - Áudio Realtek ALC236;
    - Interface de Rede Sem Fio Intel Wireless AC9462;
    - Interface de Rede Ethernet Realtek RTL810xE FE;
    - Teclado retroiluminado.
  * Extras (adicionados posteriormente)
    - SSD M.2 Nvme Crucial 500GB;
    - Dell DW1560 Broadcom BCM94352Z Rede sem fio + Bluetooth 4.0 comprada no Aliexpress.
  * Softwares
    - Mac OS Mojave 10.14.5 - 6;
    - Clover (v2.4k r4961, 2.5 5103);
    - Windows 10 64bits;
  * Upgrades futuros:
    - Acrescentar um pente de memória de 8GB DDR4.

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
  * Leitor de cartão de memória não funciona.

## 1.4 TODO (pendências)
  * syscl-USBFix: Quando o equipamento dorme as portas USB desligam e não voltam.
  * verificar questão do voltageshift
    * Undervolting with VoltageShift
https://sitechprog.blogspot.com/2017/06/voltageshift.html
https://github.com/sicreative/VoltageShift
The two links have a pretty decent explanation of how to use it.
Here is a brief explanation of how it works. VoltageShift writes these offsets to MSR. Meaning once the system shutdown completely you will lose these settings. That includes shutdown and hibernation but if you were to just restart and boot into Windows, these settings actually stay.
Apparently it doesn't persist through sleep even though it says it does. Meaning you'll have to either run the intervals or run it manually when wake. A small script makes this super easy.
When you build with their launch daemon tool, it builds a daemon which will set these offsets on boot and to the offsets in x time intervals to set them again if your laptop happened to hibernate or sleep.
I've had success with these settings CPU -25mv, GPU -90mv, Cache -125mv
./voltageshift offset -125 -90 -125
Above is for manually setting them! Follow the instructions for building the launch daemon.
My recommendation is to just set it manually for a week or so, once you know you are stable then build the launch daemon.
Also you can change these settings on the fly if you have Windows installed with Intel XTU. Test for stability there then apply the same with VoltageShift.
  * usar combojack ??
  * CPUFirend ??
  * LiluFriend?

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

Baixe o CloverThemeManager e modifique o tema do bootloader.

https://sourceforge.net/p/cloverefiboot/themes/ci/master/tree/CloverThemeManagerApp/Updates/

## 3.5 Cópia dos Kexts para a pasta /Library/Extensions

Após tudo estar funcionando da forma correta o ideal é mover as kexts da pasta /EFI/Clover/kexts/Other para a pasta /Library/Extensions

Para facilitar essa tarefa você pode utilizar a ferramenta Hackintool (https://www.tonymacx86.com/threads/release-hackintool-v2-7-1.254559/).

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

  3. Execute o comando a seguir para gerar os arquivos DSL necessários.
      > iasl -dl \*.aml

      Se aparecer "Disassembly completed" é porque deu certo.

  1. Pronto, agora basta abrir (com o MaciASL) os arquivos DSL e realizar os patches necessários.

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
      }```


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

  4. Compile, aplique e reinicie o computador

     1. Compilando

        ```
        iasl DSDT.dsl
        ```

        Observe que o comando deve retornar "Compilation complete. 0 Errors".

     1. Copie o arquivo resultante para a pasta EFI/CLOVER/ACPI/patched

     2. Reinicie o equipamento

### 4.2.3 Patches SSDT e suas finalidades

  * **SSDT-DisableDGPU.aml**

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

## 4.3 CONFIGURAÇÕES CLOVER

O arquivo config.plist utilizado tem como base o arquivo **config_HD615_620_630_640_650.plist** do repositório https://github.com/RehabMan/OS-X-Clover-Laptop-Config, mas foram feitas várias alterações por conta da utilização do Lilu e WhateverGreen.

Entre várias configurações, destaco as seguintes.

### 4.3.1 Configuração da Interface Gráfica Integrada Intel UHD 620

  ```
  <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
  <dict>
    <key>AAPL,GfxYTile</key>
    <data>
    AQAAAA==
    </data>
    <key>AAPL,ig-platform-id</key>
    <data>
    CQClPg==
    </data>
    <key>AAPL,slot-name</key>
    <string>Internal</string>
    <key>device-id</key>
    <data>
    mz4AAA==
    </data>
    <key>device_type</key>
    <string>VGA compatible controller</string>
    <key>disable-external-gpu</key>
    <data>
    AQAAAA==
    </data>
    <key>enable-hdmi20</key>
    <data>
    AQAAAA==
    </data>
    <key>framebuffer-camellia</key>
    <data>
    AwAAAA==
    </data>
    <key>framebuffer-con1-alldata</key>
    <data>
    AQEJAAAIAADHAQAA
    </data>
    <key>framebuffer-con1-enable</key>
    <data>
    AQAAAA==
    </data>
    <key>framebuffer-con2-alldata</key>
    <data>
    AgYKAAAEAADHAQAA
    </data>
    <key>framebuffer-con2-enable</key>
    <data>
    AQAAAA==
    </data>
    <key>framebuffer-fbmem</key>
    <data>
    AAAAAA==
    </data>
    <key>framebuffer-memorycount</key>
    <data>
    AwAAAA==
    </data>
    <key>framebuffer-mobile</key>
    <data>
    AQAAAA==
    </data>
    <key>framebuffer-patch-enable</key>
    <data>
    AQAAAA==
    </data>
    <key>framebuffer-pipecount</key>
    <data>
    AwAAAA==
    </data>
    <key>framebuffer-portcount</key>
    <data>
    AwAAAA==
    </data>
    <key>framebuffer-stolenmem</key>
    <data>
    AACQAw==
    </data>
    <key>framebuffer-unifiedmem</key>
    <data>
    AAAAYA==
    </data>
    <key>hda-gfx</key>
    <string>onboard-1</string>
    <key>model</key>
    <string>UHD Graphics 620 (Whiskey Lake)</string>
  </dict>
  ```

  Para verificar como configurar os conectores da interface de vídeo veja o guia Acer Swift 5 SF514-53t whiskey lake MacOS10.14.5 na referências.


### 4.3.2 Configuração do Áudio

  ```
  <key>PciRoot(0x0)/Pci(0x1f,0x3)</key>
  <dict>
    <key>#model</key>
    <string>Cannon Point-LP High Definition Audio Controller</string>
    <key>AAPL,slot-name</key>
    <string>Internal</string>
    <key>device-id</key>
    <data>
    cKEAAA==
    </data>
    <key>device_type</key>
    <string>Audio device</string>
    <key>layout-id</key>
    <data>
    CwAAAA==
    </data>
  </dict>
  ```

  Veja mais aqui: https://github.com/acidanthera/AppleALC/wiki/Supported-codecs

### 4.3.4 Boot Arguments

  * dart = 0, detabilita o VT-d apenas para o MacOS caso queira deixar a opção habilitada na BIOS
  * debug=0x100, evita que o sistema reboot em caso de kernel panic
  * agdpmod=vit9696 disables check for board-id

# 5. TESTES

## 5.1 Verificar se o powermanagement está funcionando?

Ver os seguintes artigos.

  https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/

  https://software.intel.com/en-us/articles/intel-power-gadget

## 5.2 Geekbench 4
  * Geekbench 4 CPU
    - Single-Core Score: 4670
    - Multi-Core Score: 12512
  * Geekbench 4 Computer:
    - Results: 25669

# 6. REFERÊNCIAS

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