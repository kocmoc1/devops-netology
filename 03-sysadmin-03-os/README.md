# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"
1. `stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=12288, ...}) = 0 `  
`chdir("/tmp") `
1. `stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0`  
`openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3`  
`fstat(3, {st_mode=S_IFREG|0644, st_size=111, ...}) = 0`  
`read(3, "# Magic local data for file(1) c"..., 4096) = 111`  
`read(3, "", 4096)= 0`  
`close(3) = 0`
1. `: > "/proc/$pid/fd/$fd"` или `/proc/$pid/fd/$fd > /dev/null` где $fd дескрипор записи в файл.
1. Зомби процессы не используют каких либо ресурсов ситемы, кроме не большого объема памяти для хранения дескрипторов.
1. `vagrant@vagrant:~$ sudo /usr/sbin/opensnoop-bpfcc`  
`PID    COMM               FD ERR PATH`  
`963    vminfo              6   0 /var/run/utmp`  
`579    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services`  
`579    dbus-daemon        18   0 /usr/share/dbus-1/system-services`  
`579    dbus-daemon        -1   2 /lib/dbus-1/system-services`  
`579    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/`  
1. `Part of the utsname information is also accessible via
       /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.` - Описание взял из Интернета, не понял как вызвать man на системные вызовы.
1. `;` - олсдеовательное выполнение команд  
`test -d /tmp/some_dir && echo Hi` - echo выполнится в случае если статус выхода из команды test будет равен 0  
`set -e` - Немедленный выход, если команда завершена с не нулевым статусом.  
Использование && и set -e не имеет смысла.
1. `-u` выводит ошибку если использована не установленная переменная  
    `-x` выводит команды и их аргументы так как они исполняются  
    `-o piprfail` возвращает значения конвеера (pipeline) если статус выхода последней команды не 0
1. Наиболее часто встерчающийся c статусом `interruptible sleep`, на втором месте `Idle kernel thread`.  
"<" - высокий приоритет  
"N" - низки приоритет
"L" - процесс имеет заблокированный страницы в пямяти
"s" - процессы в которых  PID == SID
"l" - многопоточные процессы  
"+" - процессы в фоновом режиме