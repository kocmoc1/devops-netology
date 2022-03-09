# Домашнее задание к занятию "7.1. Инфраструктура как код"

## 1
1. Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?  
 Ответ:  
 Так как проект только стартует и что потребуется в процессе логичнее использовать изменяемую инфраструктуру.
 
1. Будет ли центральный сервер для управления инфраструктурой?  
Ответ:  
На мой взгляд достаточно будет git репозитория.
1. Будут ли агенты на серверах?  
Ответ:  
Эффетивнее будет отказаться от агентов.
1. Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?  
Ответ:  
Одназночно да.

1. Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?  
Ответ:  
На начальном этапе Сloud Formation, Docker, Ansible. По мере роста проекта можно перейти на K8s.

1. Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?  
Ответ:  
Развитие проетка покажет какие инструменты еще понадобятся. Положенное начало достаточно гибкое для использования новых инструментов.


## 2
```buildoutcfg
PS C:\~\terraform_1.1.2_windows_amd64> .\terraform.exe -v
Terraform v1.1.2
on windows_amd64

```

## 3 
Для удобства можно занести в переменные окружения с разнами именами.
```buildoutcfg
PS C:\~\terraform_0.12.31_windows_amd64> .\terraform.exe -v
Terraform v0.12.31
Your version of Terraform is out of date! The latest version
is 1.1.2. You can update by downloading from https://www.terraform.io/downloads.html

PS C:\~\terraform_1.1.2_windows_amd64> .\terraform.exe -v
Terraform v1.1.2
on windows_amd64

```