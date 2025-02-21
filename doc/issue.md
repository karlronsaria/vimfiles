# issue

- [ ] 2025-01-06-032608
  - howto
    - in powershell

      ```powershell
      start nvim ./PsProfile/readme.md
      ```

    - in ``PsProfile/readme.md``

      ```powershell
      # todo
      - [ ] PS-version-specific modules
        - ex: ``MeasureCommand.ps1#function:ConvertFrom-Json``
      ```

  - actual

    ```text
    W325: Ignoring swapfile from Nvim process 1524
    Error detected while processing modelines:
    line    3:
    E518: Unknown option: ``MeasureCommand.ps1#function
    Press ENTER or type command to continue 
    ```

## resolved

- [x] 2023-10-17-003551
  - cancel
    - from now on, use Unix- and Json-based path strings: ``"C:/Program\ Files"``
  - what
    - function: ``gf``
  - howto
    - in ``*.md``

      ```text
      - where: "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.17.11461.0_x64__8wekyb3d8bbwe\ProfileIcons"
      ```

    - in nvim editor: ``gf``
  - actual

    ```text
    E447: Can't find file "Files\WindowsApps\Microsoft.WindowsTerminal_1.17.11461.0_x64__8wekyb3d8bbwe\ProfileIcons" in path
    ```

- [x] 2025-01-29-133609
  - where: ``StrikeAll``
  - actual

    ```markdown
    ~~#### Exception-handling~~

    ~~The user sending the wrong kind of input is one of many ways that *exceptions* can occur in your code.~~
    ~~An exception is an unexpected event that the program is not prepared for.~~
    ~~But what happens if they choose 3, or~~ 
    ```

  - expected

    ```markdown
    ~~#### Exception-handling~~

    ~~The user sending the wrong kind of input is one of many ways that *exceptions* can occur in your code.~~
    ~~An exception is an unexpected event that the program is not prepared for.~~
    ~~But what happens if they choose 3, or~~
    ```

- [x] 2023-12-21-031304
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

- [x] 2024-06-18-204333
  - where
    - ``LinkExplore``
  - howto
    - command ``LinkExplore`` with cursor over

      ```markdown
      - [howto](./howto/howto_-_2024-06-18_Cuisinart_CleanCoffeeMaker.md)
      ```

  - actual

    ```text
    File type: markdown
    Line:     - [howto](./howto/howto_-_2024-06-18_Cuisinart_CleanCoffeeMaker.md)                                                Error executing Lua callback: C:\Users\karlr\AppData\Local\nvim/lua/link.lua:20: bad argument #2 to 'gmatch' (string expected, got nil)                                                                                                                   stack traceback:                                                                                                                     [C]: in function 'gmatch'                                                                                                    C:\Users\karlr\AppData\Local\nvim/lua/link.lua:20: in function 'GetLinkTable'                                                C:\Users\karlr\AppData\Local\nvim/lua/link.lua:47: in function 'GetSystemLinkTable'                                          C:\Users\karlr\AppData\Local\nvim/lua/link.lua:105: in function <C:\Users\karlr\AppData\Local\nvim/lua/link.lua:103> Press ENTER or type command to continue
    ```

- [x] issue 2025-02-11-151656
  - where: ``Img``
  - actual

    ```markdown
    Command { oh-my-posh init pwsh --co... } is being horrible right now.
    ![2025-02-11-151633](./res/2025-02-11-151633.png)
    ```

  - solution
    - refactor pwsh instances to run with no profile by default

- [x] 2024-10-17-023317
  - where
    - ``Mdvinc``
  - actual

    ```text
    | prev rep | prev weight | | rep | weigth |
    |----------|-------------|-----|--------|
    ```

- [x] 2023-05-03-133526
  - howto
    - in program annotations
      ```cpp
      // [ ] issue 2023-05-03-133202
      ```
    - keystroke: ``:Item``
  - actual
    ```
    Pattern not found
    ```

- [x] 2023-03-22-190240
  - howto
    - command: ``:LinkReg``
    - line: ``"Where": "HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/App Paths",``
  - expected
    - ``HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/App Paths``
  - actual
    - ``HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion``

- [x] 2023-01-25-153756
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

- [x] 2022-12-16
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
