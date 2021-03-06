{% from "postgresql/map.jinja" import postgresql with context %}

postgresql:
  pkg.installed:
    - pkgs:
      - {{ postgresql.package }}
      - {{ postgresql.package_dev }}
      - {{ postgresql.contrib }}
  service.running:
    - name: {{ postgresql.service }}
    - require:
      - pkg: postgresql
    - watch:
      - file: postgresql_conf

postgresql_conf:
  file.recurse:
    - source: salt://postgresql/files/
    - name: {{ postgresql.config }}
    - template: jinja

example:
  postgres_user.present:
    - password: example
  postgres_database.present:
    - owner: example
