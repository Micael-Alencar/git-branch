# Laboratório 3 — Postmortem de Incidente

## 1. Resumo

Em 20/10/2026, foi realizado um teste controlado
de consumo elevado de CPU em um ambiente Docker.

O objetivo foi validar o monitoramento e a resposta
a incidentes utilizando cAdvisor, Prometheus e Grafana.

## 2. Infraestrutura

- Docker: gerenciamento dos containers
- Nginx: servidor web
- PostgreSQL: banco de dados
- cAdvisor: coleta de métricas
- Prometheus: armazenamento e consulta de métricas
- Grafana: dashboards e alertas

## 3. Linha do tempo

Data: 20/10/2026

- Início do estresse: horário não registrado
- 21:19:50 — Alerta de CPU elevada disparou
- 21:21:30 — Alerta retornou ao estado Normal

Duração do alerta: 1 minuto e 40 segundos.

## 4. Causa

O aumento do consumo de CPU foi provocado
intencionalmente pela execução de um container
temporário para simulação de incidente.

## 5. Detecção

O cAdvisor coletou as métricas de CPU.

O Prometheus recebeu essas métricas e o Grafana
avaliou a regra de alerta a cada 10 segundos.

Limite configurado: 0,7 núcleo de CPU.

Consumo registrado no disparo: 0,831625 núcleo.

## 6. Recuperação

Após a redução da carga, o alerta retornou
ao estado Normal às 21:21:30.

Valor registrado na normalização:
0,541415 núcleo de CPU.

## 7. MTTD

Não foi possível calcular o MTTD com precisão,
pois o horário inicial do incidente não foi registrado.

MTTD = horário da detecção - início do incidente.

## 8. Lições aprendidas

- O monitoramento detectou a condição de CPU elevada.
- O Grafana registrou o disparo e a recuperação.
- É importante registrar o início dos testes.
- Os limites dos alertas devem ser revisados.
- A documentação facilita a resposta a incidentes.

## 9. Ações de melhoria

- Registrar automaticamente o início dos incidentes.
- Manter dashboards de CPU atualizados.
- Revisar os limites de alerta periodicamente.
- Documentar procedimentos de recuperação.
- Monitorar continuamente os containers.

## 10. Conclusão

O laboratório demonstrou a integração entre
Docker, cAdvisor, Prometheus e Grafana.

O alerta de CPU elevada foi acionado e,
posteriormente, retornou ao estado Normal.

A análise foi realizada sem atribuição de culpa,
com foco na melhoria contínua.
