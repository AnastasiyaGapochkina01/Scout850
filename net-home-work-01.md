# Команды из урока
```bash
# посмотреть адреса/интерфейсы
ip -o a
ip link show
```
настройка сетевых интерфейсов: `sudo nano /etc/netplan/01-network-manager-all.yaml`
```yaml
  network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: yes
    enp0s8:
      dhcp4: no
      address: 172.16.1.5/24
```
применяем
```bash
sudo netplan generate
sudo netplan apply
```
на server устанавливаем dhcp-сервер
```bash
sudo apt install isc-dhcp-server
```
Настраиваем сервер `sudo nano /etc/dhcp/dhcpd.conf`
```ini
subnet 172.16.1.0 netmask 255.255.255.0 {
 range 172.16.1.10 172.16.1.20;
}
```
`sudo nano /etc/default/isc-dhcp-server`
```
INTERFACESv4="enp0s8"
```
рестартуем
```bash
sudo systemctl restart isc-dhcp-server.service
sudo systemctl status isc-dhcp-server.service
```
Далее на client меняем в /etc/netplan/01-network-manager-all.yaml для enp0s8 параметр dhcp на yes и убираем address; рестарутем сеть и проверяем с помощью ip
```
# Теория
Если очень хочется разобраться в основах сети, как работают устройства и протоколы, то вот это топ на русском в открытом доступе https://netskills.ru/kurs-molodogo-boitca-cisco ; он хоть и вендор-лок (cisco), но очень хорошо разжевывает базу

# Практика
1) Организовать две ВМ на базе Linux (да, именно 2 ВМ ибо будем ломать сеть, и лучше ты упорешь виртуалки, чем хостовую сеть) с именами server и client с двумя сетевыми интерфейсами
- первый с типом Bridged для связи с хостом и внешним миром
- второй с типом Internal для внутренней сети
2) Задать обеим ВМ статические ip адреса из сети 172.16.1.0/24
3) Проверить сетевую свзяность между ВМ по заданным статическим внутренним адресам
4) На ВМ server развернуть dhcp-сервер, который будет раздавать ip адреса из пула 172.16.1.10-172.16.1.20
5) На ВМ client настроить внутренний сетевой интерфейс на получение ip от dhcp сервера; проверить сетевую связность между ВМ
