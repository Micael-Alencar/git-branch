# Projeto DevOps — Terraform, Docker e Observabilidade

Projeto acadêmico desenvolvido para aplicar conceitos de infraestrutura como código (IaC), conteinerização, integração contínua, monitoramento e resposta a incidentes.

## Tecnologias utilizadas

- Terraform
- Docker
- Nginx
- PostgreSQL
- Prometheus
- Grafana
- cAdvisor
- Git e GitHub
- GitHub Actions
- Linux

## Objetivo

Construir uma infraestrutura automatizada utilizando Terraform e Docker, implementar uma pipeline de integração contínua e configurar ferramentas de observabilidade para monitorar o consumo de recursos e detectar incidentes.

## Laboratório 1 — Infraestrutura como Código

Implementação de uma infraestrutura utilizando Terraform e Docker.

### Componentes

- Container Nginx para hospedagem de um site.
- Container PostgreSQL para armazenamento de dados.
- Volume Docker para persistência do banco de dados.
- Configuração de portas e rede.

### Serviços

| Serviço | Porta |
|---------|-------|
| Nginx | 8081 |
| PostgreSQL | 5432 |

## Laboratório 2 — CI/CD

Implementação de integração contínua utilizando GitHub Actions.

### Funcionalidades

- Versionamento de código com Git.
- Armazenamento do projeto no GitHub.
- Execução automatizada de verificações.
- Validação da infraestrutura.
- Testes automatizados configurados no workflow.

O GitHub Actions foi executado com sucesso.

## Laboratório 3 — Observabilidade e Resposta a Incidentes

Implementação de monitoramento da infraestrutura com Prometheus, Grafana e cAdvisor.

### Arquitetura

```text
                  TERRAFORM
                      |
                    DOCKER
                      |
              monitoring-net
                      |
        +-------------+-------------+
        |             |             |
      Nginx       PostgreSQL      cAdvisor
                                     |
                                     v
                                 Prometheus
                                     |
                                     v
                                  Grafana
                                     |
                                     v
                              Alerta de CPU
```

### Ferramentas de monitoramento

**cAdvisor:** coleta métricas dos containers e do ambiente.

**Prometheus:** armazena e consulta métricas de monitoramento.

**Grafana:** apresenta dashboards e permite configurar alertas.

### Portas utilizadas

| Serviço | Endereço |
|---------|----------|
| Nginx | http://localhost:8081 |
| cAdvisor | http://localhost:8082 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |

Os endereços são locais ao ambiente em que as portas Docker estão publicadas.

## Dashboard de CPU

Foi criado um dashboard no Grafana para acompanhar o consumo de CPU.

Consulta PromQL utilizada:

```promql
sum by (id) (
  rate(container_cpu_usage_seconds_total{job="cadvisor"}[1m])
)
```

O dashboard permite acompanhar o comportamento dos recursos monitorados.

## Alerta de CPU elevada

Foi configurada uma regra no Grafana com as seguintes características:

| Configuração | Valor |
|-------------|-------|
| Nome | Alerta - CPU Elevada |
| Limite | 0.7 núcleo de CPU |
| Intervalo de avaliação | 10 segundos |
| Pasta | Monitoramento |

O alerta é acionado quando a condição configurada ultrapassa o limite estabelecido.

## Simulação de incidente

Foi realizado um teste de estresse para gerar consumo elevado de CPU em um container Docker.

Comando utilizado:

```bash
docker run --rm --init \
  --name estresse \
  --network monitoring-net \
  busybox \
  timeout 120 sh -c 'while true; do md5sum /dev/zero > /dev/null; done'
```

### Resultado observado

| Evento | Horário |
|--------|---------|
| Alerta disparado | 21:19:50 |
| Alerta normalizado | 21:21:30 |
| Duração do alerta | 1 minuto e 40 segundos |

**Data:** 20/10/2026.

O Grafana identificou o consumo elevado de CPU e registrou a recuperação do estado normal.

O MTTD depende do horário exato de início do teste de estresse.

## Postmortem

O relatório do incidente está disponível no arquivo:

[POSTMORTEM.md](POSTMORTEM.md)

O documento registra a análise do incidente e as oportunidades de melhoria.

## Como executar

### Pré-requisitos

- Docker instalado e em execução.
- Terraform instalado.
- Permissão para executar comandos Docker.

### Inicializar a infraestrutura

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

O Terraform poderá solicitar a variável `postgres_password`.

### Verificar os containers

```bash
docker ps
```

### Verificar o Prometheus

```bash
curl http://localhost:9090/-/healthy
```

### Verificar o Grafana

```bash
curl http://localhost:3000/api/health
```

## Estrutura principal do projeto

```text
meu-projeto/
├── .github/
│   └── workflows/
├── Site/
├── .gitignore
├── README.md
├── POSTMORTEM.md
├── infraestrutura.tf
├── main.tf
├── observabilidade.tf
├── prometheus.yml
├── providers.tf
└── .terraform.lock.hcl
```

## Resultados alcançados

- Infraestrutura provisionada com Terraform.
- Containers executados com Docker.
- Persistência dos dados do PostgreSQL.
- Pipeline CI/CD executada com sucesso.
- Monitoramento com Prometheus e cAdvisor.
- Dashboard configurado no Grafana.
- Alerta de CPU elevada funcionando.
- Incidente simulado e detectado.
- Recuperação registrada no histórico do Grafana.

## Autor

**Micael Alencar**

Estudante de Análise e Desenvolvimento de Sistemas.

GitHub: [Micael-Alencar](https://github.com/Micael-Alencar)
