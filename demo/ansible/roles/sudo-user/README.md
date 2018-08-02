# Хранение зашифрованного пароля
## Установить библиотеку
```
sudo pip install passlib
```
## Выполнить команду
```
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.using(rounds=5000).hash(getpass.getpass())"
```
## Записать результат в ./var/main.yaml
```
system_user: sysadm
system_user_pass: $6$eKPC2sTXNoLzLdMh$TTtRxXX/d41lW4vCCtTb3xK2WIx/Ut9QS6i5FMxTEbVDlDnDXISk9PctoVN.QemYg3bBO6j8diM5A.kMVOFX9.
```
