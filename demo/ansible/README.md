
# Сценари настройки инфраструктуры.
## Инструменты
Скрипт для добавления новой роли. Он просто создаст минимальную структуру каталогов и файлов.
```
ansible-playbook add_role.yaml
```

## Примеры
### Запуск теста
```
ansible-playbook main.yaml -i staging.ini
```
### Сбор фактов
```
 ansible all -i staging.ini -t bareos-fd -m setup | less
 ```

## Стандартная структура каталогов и файлов
Структура взята с [Best Practices | http://docs.ansible.com/ansible/latest/playbooks_best_practices.html]
```
├── production (Инвентарный файл)
├── staging (Инвентарный файл для проверки)
│
├── group_vars (Назначение переменных для групп)
│   └── README.md
├── host_vars (Назначение переменных для хостов)
│   └── README.md
├── filter_plugins (Специфичные кастомные плагины фильтров)
│   └── README.md
├── library (Специфичные кастомные модули)
│   └── README.md
├── module_utils (Специфичные кастомные утилиты)
│   └── README.md
├── roles (Иерархия доступных ролей)
│   ├── common (Общая роль)
│   │   └── README.md
│   ├── <Role....>
│   │   └── README.md
│   └── README.md
│
└── README.md
```
## Роли
## Инвентарные файлы
## Переменные
