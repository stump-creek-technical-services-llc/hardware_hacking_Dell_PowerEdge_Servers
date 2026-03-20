# Dell PowerEdge Servers

This hack is different from the others.
Perhaps its more of simply a teardown.

I purchased three gutted Dell PowerEdge servers.
I bought them mostly thinking that I could look at the chips,
maybe salvage a few,
and might be able to use the chassis for other projects.

## Dell PowerEdge R630 (2017)

![R630-2017_case_inside.jpg](photos/R630-2017_case_inside.jpg)

![R630-2017_case_label.jpg](photos/R630-2017_case_label.jpg)

```text
DELL EMC PowerEdge R630
Service Tag: BLD7HK2
Express Service Code: 25236579746
Mfg. Date: 20170717
```

1U height

## Dell PowerEdge R630 (2015)

![R630-2015_case_inside.jpg](photos/R630-2015_case_inside.jpg)

![R630-2015_case_label.jpg](photos/R630-2015_case_label.jpg)

```text
Service Tag: B1SPB42
Express Service Code: 24053281922
Mfg. Date: 20150321
```

1U height

## Dell PowerEdge R630 (2016)

![R630-2016_case_label.jpg](photos/R630-2016_case_label.jpg)

![R630-2016_case_inside.jpg](photos/R630-2016_case_inside.jpg)

```text
Service Tag: 7NYXF2S
Express Service Code: 16686864532
```

2U height

This unit appears to be storage-optimized.
It had lots of fans and I think space for twelve 3.5" drives.

## Boards

I made no effort to keep the parts from the three units separate
once they were in pieces.
The photos have mostly shown which piece belonged to which unit,
but they still could be mixed up.

![boards_chaos.jpg](photos/boards_chaos.jpg)

Here are some of the more interesting parts I found:

### VGA Extension

This board exposed a VGA port at the front of the unit.

![board_vga_side_1.jpg](photos/board_vga_side_1.jpg)

![board_vga_side_2.jpg](photos/board_vga_side_2.jpg)

![board_vga_side_1_diodes.jpg](photos/board_vga_side_1_diodes.jpg)

According to my research, these SOT-23 packages are protection diodes.
They are biased against the VGA signal, so they don't normally conduct.
They are meant to protect against static electricity discharges.
The discharge would flow with the forward direction of the diodes and be conducted safely to ground.

### SD Extension

This board exposed an SD card port at the front of the unit.

![board_sd_breakout_top.jpg](photos/board_sd_breakout_top.jpg)

![board_sd_breakout_bottom.jpg](photos/board_sd_breakout_bottom.jpg)

I'm interested in SD cards and readers,
so I kept this board around.

### Control Panel

This board also brought SD card and some other signals to the front panel,
but has a number of functions all on one board.

![board_control_panel_top.jpg](photos/board_control_panel_top.jpg)

![board_control_panel_bottom.jpg](photos/board_control_panel_bottom.jpg)

### LSI IO Board

Now this one is interesting.
I think it came from the 2U R630-2016 server.

![board_lsi_hba_top.jpg](photos/board_lsi_hba_top.jpg)

![board_lsi_hba_bottom.jpg](photos/board_lsi_hba_bottom.jpg)

This device appears to be a sophisticated system on its own.
The LSI chip is a SAS expander,
meaning that it is meant to host a bunch of SAS drives.
It most likely connects to the host PCI Express bus(es)
via those grey connectors on the lower edge.

#### LSI SAS3X24R SAS Expander

![chip_lsi_hba_LSI_SAS3X24R.jpg](photos/chip_lsi_hba_LSI_SAS3X24R.jpg)

* Package: FCBGA?

Markings:

```text
LSI*
500021255
SAS3X24R
1709   e1
APU0900Q
TAIWAN
```

My sources say it has an ARM Cortex-R4 SoC.

#### Spansion 16 MiB Parallel NOR Flash Memory

![chip_lsi_hba_Spansion.jpg](photos/chip_lsi_hba_Spansion.jpg)

* Package: TSOP-56 Type I
* 128 Mib = 16 MiB

Markings:

```text
SPANSION
S29GL128S10TFIV2
710BB198 B
©10 SPANSION
```

This chip likely contains the main firmware for the LSI SoC.
Being NOR flash, it can be exe/ed in place.
With a parallel interface, it probably has pretty good bandwidth.

#### Everspin MRAM

This is a special chip: magnetoresistive RAM.
It's non-volatile, but as fast as SRAM.

![chip_lsi_hba_Everspin.jpg](photos/chip_lsi_hba_Everspin.jpg)

* 1 Mib = 128 KiB
* Package: FBGA-48

Markings:

```text
MR0D08BMA45
G991651
```

#### ST EEPROM

This chip probably contains settings for the LSI SAS expander.
Google thinks it has the FRU serial numbers, etc.
I think we should find out!

![chip_lsi_hba_ST_24C04RP.jpg](photos/chip_lsi_hba_ST_24C04RP.jpg)

* Interface: I2C
* 4 Kib, 512 B
* Package: SO8N

Markings:

```text
24C04RP
ST K645T
```

### Front Panel Switches and Character Display

I'm definitely keeping this thing!

![board_char_display_front.jpg](photos/board_char_display_front.jpg)

![board_char_display_rear.jpg](photos/board_char_display_rear.jpg)

### Dell R630 (2015) Motherboard

Based on the copyright, I'm guessing that this was from the 2015 unit.

![board_R630-2015_motherboard_top.jpg](photos/board_R630-2015_motherboard_top.jpg)

![board_R630-2015_motherboard_bottom.jpg](photos/board_R630-2015_motherboard_bottom.jpg)


#### Integrated Dell Remote Access Controller (iDRAC)

Dell has a proprietary host management system called Integrated Dell Remote Access Controller (iDRAC).
The controller is a complete host on its own,
which is interesting.
It's located in the upper-right corner of the motherboard,
which I think would be the rear-left of the chassis.

If I recall correctly, the two slots on the left were risers to PCIe slots.
They are more likely not connected to the iDRAC,
but many of the ports at the top edge (rear of the chassis)
and associate driver chips probably are connected through the iDRAC.

![board_R630-2015_iDRAC_top.jpg](photos/board_R630-2015_iDRAC_top.jpg)

![board_R630-2015_iDRAC_bottom.jpg](photos/board_R630-2015_iDRAC_bottom.jpg)

Close-up of the upper half:

![board_R630-2015_iDRAC_top_upper.jpg](photos/board_R630-2015_iDRAC_top_upper.jpg)

And lower half:

![board_R630-2015_iDRAC_top_lower.jpg](photos/board_R630-2015_iDRAC_top_lower.jpg)

##### iDRAC SoC

![chip_R360-2015_iDRAC.jpg](photos/chip_R360-2015_iDRAC.jpg)

* Package FCBGA

Markings:

```text
SH77572
ROM-A41
449CP04
```

Google tells me that this was a SuperH SH-4A RISC chip,
which isn't a name I've heard often.

Google also tells me that ROM-A41 is probably the ID
of the firmware version that was burned into the chip.

##### ALTERA CPLD

This chip is a Complex Programmable Logic Device.

![chip_R630-2015_iDRAC_CPLD.jpg](photos/chip_R630-2015_iDRAC_CPLD.jpg)

![chip_R630-2015_iDRAC_CPLD_2.jpg](photos/chip_R630-2015_iDRAC_CPLD_2.jpg)

* Package: FBGA-256

Markings:

```text
ALTERA
MAX II
EPM1270F256SSN
N CAQ09M144SC
KOREA
VAQ9M71315
3U1NU4XOB (e1)
```

##### SanDisk eMMC

I think that the CPLD and SoC already have their own on-board storage,
so I'm curious what this chip was connected to.
I guess it's more likely the SoC.
Maybe the on-board storage was limited or just has a bootloader.
The eMMC might have a larger system partition.
It might also be for log storage.

![chip_R630-2015_iDRAC_eMMC.jpg](photos/chip_R630-2015_iDRAC_eMMC.jpg)

![chip_R630-2015_iDRAC_eMMC_2.jpg](photos/chip_R630-2015_iDRAC_eMMC_2.jpg)

* Package: FBGA-153
* 32 Gib = 4 GiB

Markings:

```text
SDIN7DP2-4G
CHINA
4094DFYTA12U
```

##### DDR3-1600 SDRAM

![chip_R630-2015_iDRAC_RAM.jpg](photos/chip_R630-2015_iDRAC_RAM.jpg)

![chip_R630-2015_iDRAC_RAM_2.jpg](photos/chip_R630-2015_iDRAC_RAM_2.jpg)

* Package: FBGA-96
* 2 Gib = 256 MiB

Markings:

```text
SKHynix
H5TQ2G63FFR
PBC    444V
NW3K2378XH2
```

Perhaps the iDRAC is less of a SoC if it has external RAM and storage.

##### Texas Instruments SN74CBTLV3253 Multiplexer

There are a bunch of these chips on this board.
They are combination multiplexer, demultiplexer, and level shifter.
I'm guessing that the iDRAC SoC is a particularly low-voltage device, maybe 1.8 volt device.
These chips probably enable it to communicate with a bunch of simple devices
at little cost of I/O pads and at its preferred voltage.

![chip_R630-2015_iDRAC_CL253.jpg](photos/chip_R630-2015_iDRAC_CL253.jpg)

* Package: TSSOP-16

Markings:

```text
CL256
 49M
AN8QG4
```

##### Nuvoton TPM 1.2

Recall the whole issue about Windows 11 not working on a lot of computers?
This is why.
Windows 11 requires TPM 1.3, and this chip is a 1.2.

![chip_R630-2015_iDRAC_TPM.jpg](photos/chip_R630-2015_iDRAC_TPM.jpg)

* Package: TSSOP-28

Markings:

```text
nuvoTon
NPCT420JA1WX
2437M0092
437GAFD
```

##### JTAG

Probably hackable.

![conn_R630-2015_iDRAC_CPLD_JTAG.jpg](photos/conn_R630-2015_iDRAC_CPLD_JTAG.jpg)

##### UART

![conn_R630-2015_iDRAC_UART.jpg](photos/conn_R630-2015_iDRAC_UART.jpg)

I wonder what it would have said if I could have accessed it.

#### Macronix MX25L6445EMI BIOS

![chip_R630-2015_BIOS.jpg](photos/chip_R630-2015_BIOS.jpg)

* Serial NOR flash memory
* 64 Mib = 4 MiB
* Package: SOIC-16

Markings:

```text
MXIC B142655
MX25L6445EMI-10G
3Q3009500
```

Filename: `dell_poweredge_r630_mx25l6445emi_3q3009500.bin`

#### Intel Platform Controller Hub

![chip_R630-2015_PCH.jpg](photos/chip_R630-2015_PCH.jpg)

* Package: FCBGA-901

Markings:

```text
i BD82C602J
SLJNG
E444C554
©️09(e1)
```

## ROMs 

I don't remember which chip came from which board,
but there are several ROMs to check out.

### Macronix MX25L3206E

![chip_Macronix_MX25L3206E_K164876.jpg](photos/chip_Macronix_MX25L3206E_K164876.jpg)

* 32 Mib = 4 MiB
* Package: SOIC-8

Markings:

```text
MXIC MX
25L3206E
M2I-12G
3X381500
K164876
```

Google says that `3X381500` suggests the 38th week of 2015,
which might imply this was from the 2015 unit.

Filename: `dell_poweredge_r630_mx25l3206e_k164876.bin`

### Winbond W25Q64BVF1G

![chip_Winbond_W25Q64BVF1G_1207.jpg](photos/chip_Winbond_W25Q64BVF1G_1207.jpg)

* 64 Mib = 8 MiB
* Package: SOIC-16

Markings:

```text
winbond
W25Q64BVF1G
1207
```

[Datasheet](https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/653/W25Q64BV.pdf)

Filename: `dell_poweredge_r630_w25q64bvf1g_1207.bin`

### Macronix MX25L12873FMI

![chip_Macronix_MX25L12873FMI_8D148100.jpg](photos/chip_Macronix_MX25L12873FMI_8D148100.jpg)

* 128 Mib = 16 MiB
* Package: SOIC-16

Markings:

```text
MXIC B165304
MX25L12873FMI-10G
8D148100
```

Filename: `dell_poweredge_r630_mx25l12873fmi_8d148100.bin`

### Atmel 25DF321A

![chip_Atmel_25DF321A.jpg](photos/chip_Atmel_25DF321A.jpg)

I think this one came off of one of the SAS expansion boards.

* 32 Mib = 4 MiB
* Package: SOIC-8

Markings:

```text
ATMEL1210
25DF321A
SH
```

Filename: `dell_poweredge_r630_atmel_25df321a_sh.bin`

## Firmware

## Conclusion: ?
