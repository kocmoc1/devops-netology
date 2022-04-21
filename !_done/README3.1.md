#Домашнее задание к занятию «3.1. Работа в терминале, лекция 1»
{:start="5"}

5. Какие ресурсы выделены по-умолчанию?
	Base memory: 1024 Mb
	Processors: 2
	Storage: 64 GB (Dynamicaly)
	Network: Nat
6.
	config.vm.provider "virtualbox" do |v|
		v.memory = 2048 
		v.cpus = 2 
	end
8.1 int history_length; Line 375
8.2 ignoreboth-  don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
Опция HISTCONTROL контролирует каким образом список команд сохраняется в истории.
ignorespace — не сохранять строки начинающиеся с символа <пробел>
ignoredups — не сохранять строки, совпадающие с последней выполненной командой
ignoreboth — использовать обе опции ‘ignorespace’ и ‘ignoredups’
erasedups — удалять ВСЕ дубликаты команд с истории
9. В сценариях с списками. Line 236
{ list }
              list is simply executed in the current shell environment.  list must be terminated with a newline or semicolon.  This is known
              as a group command.  The return status is the exit status of list.  Note that unlike the metacharacters ( and ), { and  }  are
              reserved words and must occur where a reserved word is permitted to be recognized.  Since they do not cause a word break, they
              must be separated from list by whitespace or another shell metacharacter.

10. touch file{1..100000}
	touch file{1..300000}
	-bash: /usr/bin/touch: Argument list too long; 
		Список аргументов больше буфера для аргментов.
11. [[ -d /tmp ]] - проверяет является ли /tmp файлом 

12. [ссылка на Google Drive](https://drive.google.com/file/d/1bWfTNOdnuZ4hocx8bNmo8toV0_g6lOoT/view?usp=sharing)
13. at – запускает команды в заданное время;  
batch – запускает команды, когда уровни загрузки системы позволяют это делать; в других, когда средняя загрузка системы, читаемая из /proc/loadavg, опускается ниже 1.5, или величины, заданной при вызове atd.