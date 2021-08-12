### git command

Если запушили не то или передумали, но уже поздно
!!! откатит на предыдущий коммит, обратного пути нет !!!
```
git reset --hard HEAD^
```
Принудительно влить изменения
```
git push -f origin develop
```

Если кто-то уже все "поправил", то
```
git checkout master
git branch -D develop
git checkout develop
```