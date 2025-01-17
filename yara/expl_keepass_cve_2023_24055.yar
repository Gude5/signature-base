
rule EXPL_Keepass_CVE_2023_24055_Jan23 {
   meta:
      description = "Detects suspicious entries in the Keepass configuration file, which could be indicator of the exploitation of CVE-2023-24055"
      author = "Florian Roth"
      reference = "https://github.com/alt3kx/CVE-2023-24055_PoC"
      date = "2023-01-25"
      score = 75
   strings:
      $a1 = "<TriggerCollection xmlns:xsi=" ascii wide

      $x1 = "<Parameter>KeePass XML (2.x)</Parameter>"
      $x2 = "::ReadAllBytes("
      $x3 = " -Method "
      $x4 = " bypass "
      $x5 = "powershell" nocase ascii wide fullword
   condition:
      filesize < 200KB and $a1 and 1 of ($x*)
}

rule SUSP_Keepass_CVE_2023_24055_Jan23 {
   meta:
      description = "Detects suspicious triggers defined in the Keepass configuration file, which could be indicator of the exploitation of CVE-2023-24055"
      author = "Florian Roth"
      reference = "https://github.com/alt3kx/CVE-2023-24055_PoC"
      date = "2023-01-25"
      score = 60
   strings:
      $a1 = "<TriggerCollection xmlns:xsi=" ascii wide

      $s1 = "<Action>" ascii wide
      $s2 = "<Parameter>" ascii wide
   condition:
      filesize < 200KB and $a1 and all of ($s*)
}
