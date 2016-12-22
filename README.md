Docker Contao
===

Contao Open Source CMS

Quick Start
---

```
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=mypass -e MYSQL_DATABASE=contao mysql
docker run -d --name contao -p 80:80 --link mysql:mysql medialta/docker-contao
```

Point your browser to `http://127.0.0.1`

Contao Installation
---

Once you're up and running, you'll arrive at the configuration wizard page. At the `Database connection` step, please enter the following:

- Host: `mysql`
- Login: `root`
- Password: `mypass`
- Database Name: `contao`

License
---

MIT


**Free Software, Hell Yeah!**
