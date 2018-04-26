# cliParse
haskell exercise from Functional Haskell tutorial

continuous compilation/exec cliParser
```bash
stack build --fast --file-watch --exec cliParser-exe
```

to run
```bash

stack exec -- cliParser-exe                                                                                                                   
Missing: ITEMINDEX ((-d|--desc DESCRIPTION) | --clear-desc)

stack exec -- cliParser-exe 1234 -p foo -d desc                                                                                               
options=Options "foo" 1234 (Just "desc")

stack exec -- cliParser-exe 1234  -d desc                                                                                                     
options=Options "~/.to-do.yaml" 1234 (Just "desc")

Usage: cliParser-exe [-p|--data-path DATAPATH] ITEMINDEX
                     ((-d|--desc DESCRIPTION) | --clear-desc)
  To-do list manager

stack exec -- cliParser-exe 1234 -p foo --clear-desc                                                                                          
options=Options "foo" 1234 Nothing


```