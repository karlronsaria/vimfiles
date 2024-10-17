# issue

- [ ] 2024_06_18_204333
  - where
    - ``LinkExplore``
  - howto
    - command ``LinkExplore`` with cursor over

      ```markdown
      - [howto](./howto/howto_-_2024_06_18_Cuisinart_CleanCoffeeMaker.md)
      ```

  - actual

    ```text
    File type: markdown
    Line:     - [howto](./howto/howto_-_2024_06_18_Cuisinart_CleanCoffeeMaker.md)                                                Error executing Lua callback: C:\Users\karlr\AppData\Local\nvim/lua/link.lua:20: bad argument #2 to 'gmatch' (string expected, got nil)                                                                                                                   stack traceback:                                                                                                                     [C]: in function 'gmatch'                                                                                                    C:\Users\karlr\AppData\Local\nvim/lua/link.lua:20: in function 'GetLinkTable'                                                C:\Users\karlr\AppData\Local\nvim/lua/link.lua:47: in function 'GetSystemLinkTable'                                          C:\Users\karlr\AppData\Local\nvim/lua/link.lua:105: in function <C:\Users\karlr\AppData\Local\nvim/lua/link.lua:103> Press ENTER or type command to continue
    ```

- [ ] 2023_12_21_031304
  - where
    - function: ``Img``
  - howto
    - generate current file in editor by calling write-to: ``":w"``
  - actual
    - saves images to ``.\res\`` in ``C:\Users\karlr\``
  - expected
    - saves images to ``.\res\`` in working directory of file
  - problem
    - unable to locate working directory of file when creating file in nvim editor

- [ ] 2023_10_17_003551
  - what
    - function: ``gf``
  - howto
    - in ``*.md``
      ```
      - where: "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.17.11461.0_x64__8wekyb3d8bbwe\ProfileIcons"
      ```
    - in nvim editor: ``gf``
  - actual
    ```
    E447: Can't find file "Files\WindowsApps\Microsoft.WindowsTerminal_1.17.11461.0_x64__8wekyb3d8bbwe\ProfileIcons" in path
    ```

## resolved

- [x] 2024_10_17_023317
  - where
    - ``Mdvinc``
  - actual

    ```text
    | prev rep | prev weight | | rep | weigth |
    |----------|-------------|-----|--------|
    ```

- [x] 2023_05_03_133526
  - howto
    - in program annotations
      ```cpp
      // [ ] issue 2023_05_03_133202
      ```
    - keystroke: ``:Item``
  - actual
    ```
    Pattern not found
    ```

- [x] 2023_03_22_190240
  - howto
    - command: ``:LinkReg``
    - line: ``"Where": "HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/App Paths",``
  - expected
    - ``HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/App Paths``
  - actual
    - ``HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion``

- [x] 2023_01_25_153756
  - howto
    ``nvim``
  - actual
    ```
    Error detected while processing C:\Users\karlr\AppData\Local\nvim\init.lua:
    E5113: Error while calling lua chunk: C:\Users\karlr\AppData\Local\nvim/lua/define.lua:9: Vim(edit):E499: Empty file name for '%' or '#', only works with ":p:h": :ed ++ff=dos
    stack traceback:
            [C]: in function 'cmd'
            C:\Users\karlr\AppData\Local\nvim/lua/define.lua:9: in function 'source'
            C:\Users\karlr\AppData\Local\nvim\init.lua:19: in main chunk
    Press ENTER or type command to continue
    ```

- [x] 2022_12_16
  - howto
    - keystroke: ``:Item``
  - actual
    ```
    ### todo
    - [x] cash cheques
       ~
      - [x] ``A`` emp: tell Cindy I have cheques that need to be deposited
         ~

    ### !emp
    - [x] see [``todo A``](#todo)
       ~~~~~~~~~~~~~~~~~~
    ```
  - expected
    ```
    ### todo
    - [x] cash cheques
       ~
      - [x] ``A`` emp: tell Cindy I have cheques that need to be deposited
         ~

    ### !emp
    - [x] see [``todo A``](#todo)
       ~
    ```

---
[← Go Back](../readme.md)
