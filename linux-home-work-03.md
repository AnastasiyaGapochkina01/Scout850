# Справка
## RAID
```bash
# Просмотр информации о блочных устройствах
lsblk
# Создание RAID-массива уровня 5; /dev/md0 - имя устройства; --level=5 - уровень RAID; --raid-devices=3 - количество устройств в массиве
sudo mdadm --create --verbose /dev/md0 --level=5  --raid-devices=3 /dev/vdb /dev/vdc /dev/vdd
# Проверка состояния RAID-массива
cat /proc/mdstat
# DEVICE partitions - указывает mdadm сканировать все разделы при поиске компонентов RAID; без этой настройки массив может не собраться при перезагрузке
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
# Сохранение информации о массиве в конфиг
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf

# Создание файловой системы и директории для монтирования
sudo mkfs.ext4 /dev/md0
sudo mkdir /raid
# Ищем UUID устройства
sudo blkid
# Прописываем постоянное монтирование 
sudo vim /etc/fstab
  UUID=      /raid     ext4    defaults    1 2
# Проверяет корректность записи в fstab и выполняет само монтирование
sudo mount -a
# Проверка
df -Th
sudo mdadm --detail /dev/md0

# Инсценировка поломки диска
sudo mdadm /dev/md0 --fail /dev/vdb
cat /proc/mdstat
# Удаляет сбойный дсик
mdadm /dev/md0 --remove /dev/vdb
# Добавляет новый диск в массив
sudo mdadm /dev/md0 --add /dev/vde
watch cat /proc/mdstat
```
## LVM
```bash
# Установка lvm, если еще не установлен
apt install lvm2
# Просмотр текущих LVM-объектов (PV/VG/LV)
pvs
pvdisplay
vgs
vgdisplay
lvs
lvdisplay
# Создание физических томов
pvcreate /dev/vdb1
pvcreate /dev/vdb2
pvs
# Создание группы томов
vgcreate databases /dev/vdb1 /dev/vdb2
vgs
# Создание логического тома
lvcreate -n mysql -L1G databases
lvs
mkfs.ext4 /dev/mapper/databases-mysql
mkdir /opt/mysql
blkid
vim /etc/fstab
mount -a
df -h

lvextend -L+1G /dev/databases/mysql
lvextend -l +100%FREE /dev/databases/mysql
# или указать конечный размер
lvextend -L2G /dev/databases/mysql
# Расширение ФС
resize2fs /dev/databases/mysql
df -Th
```

# Задания
## Часть 1
1) Добавить два дополнительных диска к ВМ
2) Установить на ВМ postgresql, убедиться что он запущен
3) Выяснить, в какой директории postgres хранит данные
```
sudo su - postgres
psql
# SHOW data_directory;
```
4) На одном новом диске создать 2 раздела (обычных, с помощью fdisk)
5) Второй диск полностью отдать под LVM:
- сделать из него PV
- из PV сделать VG
- из VG отрезать раздел под данные postgresql
6) Смонтировать созданный раздел в директорию, которую нашли в задании 3
7) Создать из двух разделов на оставшемся диске два PV
8) Добавить их в сущеуствующую VG
9) Увеличить размер LV под данными postgres

## Часть 2
1) Установить mongodb
2) Выяснить, где находится директория с данными командой ```grep -i dbPath /etc/mongod.conf```
3) Подключить еще один дополнительный диск к ВМ
4) Сделать из нового диска PV, из PV - VG
5) Создать Logical Volume mongo-data и вынести директорию из п.6 на него
6) Убедиться, что все прошло корректно (сервис mongodb запущен, можно подключиться к БД)

## Часть 3
1) К ВМ добавить 4 диска размером по 1G
2) Собрать raid 1 из двух любых дисков и смонтировать его в /mnt/raid1; в директории /mnt/raid1 создать файл important-data с содержимым
```
Username	Identifier	First name	Last name
booker12	9012	Rachel	Booker
grey07	2070	Laura	Grey
johnson81	4081	Craig	Johnson
jenkins46	9346	Mary	Jenkins
smith79	5079	Jamie	Smith
```
3) Симулировать сбой одного из дисков; удалить один диск из массива и на его место поставить другой; после пересборки массива проверить, что файл important-data на месте и не изменился
4) Остановить и разобрать raid 1
<details>
  <summary>Подсказка</summary>
  
  ```bash
  sudo umount /mnt/raid1
  sudo mdadm --stop /dev/md0
  sudo mdadm --zero-superblock /dev/vdb /dev/vdc
  ```
  
</details>
5) Собрать raid-5 и на него поставить файловую систему xfs; смонтировать в /mnt/raid5
6) Аналогично тому, как делал c raid-1 создать файл, симулировать сбой и проверить целостность данных
