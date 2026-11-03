# AGENTS.md — colaboração ChatGPT + Cursor
> Projeto: isatecinfo — plataforma e operação digital da Isa TecInfo.
> Fonte de verdade: código, testes, issues e PRs deste repositório. Não presumir que o histórico do chat está atualizado.

## Papéis
- ChatGPT: requisitos, decomposição em tarefas, revisão de arquitetura, leitura e revisão dos PRs, critérios de aceite, planejamento de release.
- Cursor: implementação no workspace local, execução e registro de testes, correções pontuais, commits e abertura de PR.
- GitHub: histórico de decisões, PRs, issues e releases. Obsidian: visão de portfólio e notas, não uma segunda fonte do código.

## Antes de trabalhar
1. Ler README, package.json/arquivos de build, estrutura, testes, instruções existentes e PRs relevantes. Verificar o estado real em vez de inventar comandos, resultados ou integrações.
2. Confirmar objetivo, dependências, critérios de aceite e escopo. Priorizar a menor alteração segura; evitar refatoração não solicitada.
3. Não misturar mudanças de funcionalidades distintas no mesmo PR e não alterar dados/serviços de produção sem autorização específica.

## Implementação e qualidade
- Trabalhar em branch por tarefa; preservar arquitetura, padrões de UI, acessibilidade, validações, segurança, isolamento de dados e comportamento mobile existentes.
- Criar/atualizar testes unitários e de integração e e2e quando a mudança exigir; executar localmente os comandos reais identificados no projeto.
- Antes de abrir PR: executar testes aplicáveis localmente e registrar comando + resultado verificável. Se ambiente, credenciais ou serviços impedirem execução, informar exatamente o bloqueio; jamais dizer que testou se não testou.
- Em documentação-only, registrar análise de impacto e informar quando nenhum teste automatizado foi necessário.
- **Economia de GitHub Actions**: não criar/adicionar workflows com triggers `pull_request` ou `push` indiscriminados; execução remota só nos eventos de publicação explicitamente aprovados, observando os workflows já existentes.
- Não armazenar tokens, chaves, senhas, dados pessoais ou segredos em prompts, notas, arquivos versionados ou logs.

## Passagem de contexto com baixo custo
- Atualizar `docs/AI_HANDOFF.md` após trabalho relevante, mantendo conciso: objetivo, estado efetivo, arquivos alterados, testes executados, bloqueios, próximo passo e links de issue/PR. Não copiar a conversa inteira.
- Para retomar: primeiro ler `docs/AI_HANDOFF.md` e o diff/issue correspondente; só então pesquisar no restante do projeto.
- Preferir buscas localizadas, diffs e arquivos específicos à leitura repetida de todo o repositório. Usar modelo/custo adequados à complexidade e evitar duas IAs implementarem a mesma tarefa simultaneamente.

## Entrega
PR deve conter: resumo, risco, evidência dos testes locais, migrações/configuração necessárias, checklist de aceite e impacto em publicação. Merge e deploy apenas após revisão e validação.