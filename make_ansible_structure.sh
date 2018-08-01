#!/usr/bin/env bash
set -o errexit # используйте "|| true" чтобы игнорировать ошибки
set -o nounset
set -o pipefail

PROJECTPATH='.'
#PROJECTNAME='ansible'

#arg1="${1:-}"

ME=$0


function print_help() {
    echo "Генератор структуры каталогов для нового проекта Ansible"
    echo
    echo "Использование: $ME options..."
    echo "Параметры:"
    echo "  -n <name>     Обязательный. Имя каталога проекта."
    echo "  -p <path>     Опциональный. Указать путь где будет создан каталог проекта.  (По умолчанию будет создан в текущем каталоге)"
    echo "  -h            Справка."
    echo
}


while getopts "p:n:h" OPT ;
do
  case ${OPT} in
        p) PROJECTPATH=${OPTARG};
            ;;
        n) PROJECTNAME=${OPTARG};
            ;;
        h) print_help;
            exit 0;
            ;;
        *) echo "Для вызова справки запустите $ME -h";
            exit 1
            ;;
        esac
done

if [ -z "${PROJECTNAME:-}" ]; then
  print_help
  exit 1
fi

mkdir -p ${PROJECTPATH}/${PROJECTNAME}
echo "
# Сценари настройки инфраструктуры.
## Примеры
### Saple1....
### Saple2....
## Стандартная структура каталогов и файлов
Структура взята с [Best Practices | http://docs.ansible.com/ansible/latest/playbooks_best_practices.html]
\`\`\`
├── production (Инвентарный файл)
├── staging (Инвентарный файл для проверки)
│
├── group_vars (Назначение переменных для групп)
│   └── README.md
├── host_vars (Назначение переменных для хостов)
│   └── README.md
├── filter_plugins (Специфичные "кастомные" плагины фильтров)
│   └── README.md
├── library (Специфичные "кастомные" модули)
│   └── README.md
├── module_utils (Специфичные "кастомные" утилиты)
│   └── README.md
├── roles (Иерархия доступных ролей)
│   ├── common (Общая роль)
│   │   └── README.md
│   ├── <Role....>
│   │   └── README.md
│   └── README.md
│
└── README.md
\`\`\`
## Роли
## Инвентарные файлы
## Переменные
"> ${PROJECTPATH}/${PROJECTNAME}/README.md

touch ${PROJECTPATH}/${PROJECTNAME}/production
touch ${PROJECTPATH}/${PROJECTNAME}/staging

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/group_vars
echo "
# Назначение переменных для групп
"> ${PROJECTPATH}/${PROJECTNAME}/group_vars/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/host_vars
echo "
# Назначение переменных для хостов
"> ${PROJECTPATH}/${PROJECTNAME}/host_vars/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/library
echo "
# Специфичные (кастомные) модули
"> ${PROJECTPATH}/${PROJECTNAME}/library/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/module_utils
echo "
# Специфичные (кастомные) утилиты
"> ${PROJECTPATH}/${PROJECTNAME}/module_utils/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/filter_plugins
echo "
# Специфичные (кастомные) плагины фильтров
"> ${PROJECTPATH}/${PROJECTNAME}/filter_plugins/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles
echo "
# Иерархия доступных ролей
## Стандартная структура каталогов и файлов для роли
Структура взята с [Best Practices | http://docs.ansible.com/ansible/latest/playbooks_best_practices.html]
\`\`\`
├── roles
│   ├── common
│   │   ├── defaults
│   │   │   └── main.yml
│   │   ├── files
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── library
│   │   ├── lookup_plugins
│   │   ├── meta
│   │   │   └── main.yml
│   │   ├── module_utils
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   └── vars
│   │       └── main.yml
│   └── README.md
\`\`\`

"> ${PROJECTPATH}/${PROJECTNAME}/roles/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common
echo "
# Общая роль
## Переменные
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/README.md

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/tasks

echo "
--
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/tasks/main.yml

mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/handlers/
echo "
--
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/handlers/main.yml
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/templates/
touch ${PROJECTPATH}/${PROJECTNAME}/roles/common/templates/.gitignore
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/files/
touch ${PROJECTPATH}/${PROJECTNAME}/roles/common/files/.gitignore
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/vars/
echo "
--
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/vars/main.yml
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/defaults/
echo "
--
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/defaults/main.yml
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/meta/
echo "
--
"> ${PROJECTPATH}/${PROJECTNAME}/roles/common/meta/main.yml
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/library/
touch ${PROJECTPATH}/${PROJECTNAME}/roles/common/library/.gitignore
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/module_utils/
touch ${PROJECTPATH}/${PROJECTNAME}/roles/common/module_utils/.gitignore
mkdir -p ${PROJECTPATH}/${PROJECTNAME}/roles/common/lookup_plugins/
touch ${PROJECTPATH}/${PROJECTNAME}/roles/common/lookup_plugins/.gitignore
