# devops-netology
devops-netology
#Poskrebyshev Nikolay
##Описание .gitignore
### Не попадут в git:
1. Все файлы в всех каталогах в каталоге .terraform
2. Все файлы с расширением .tfstate или содержащие в названии .tfstate.
3. файл crash.log
4. Файлы override.tf, override.tf.json, а также заканчивающиеся на _override.tf и _override.tf.json
5. Файлы .terraformrc, terraform.rc