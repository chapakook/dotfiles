# Global Instructions

## Git Commit Rules

When committing to d3v1n8 repositories:
- Do not add AI attribution or Co-Authored-By to commit messages or pull requests unless the user explicitly requests it.

@~/.claude/pstack-models.md

## pstack `codex:` 엔트리

`pstack-models.md`의 엔트리가 `codex:<model>[:<effort>]` 형식이면 `Agent` 호출이 아니라 Codex CLI로 그 좌석을 돌린다. 거절된 엔트리로 보고 Claude 모델로 대체하거나 빼지 않는다.

- 다른 좌석과 같은 프롬프트를 스크래치패드 파일에 쓰고, Bash `run_in_background`로 `codex exec -m <model> -c model_reasoning_effort=<effort> -s read-only -C <대상 디렉토리> -o <스크래치패드>/codex-<스킬>-<n>.md - < <프롬프트 파일>`을 실행한다. effort가 없으면 `-c` 옵션을 뺀다.
- 파일을 써야 하는 좌석(arena·architect 후보, 재현 스크립트·테스트를 돌려야 하는 interrogate 공격자)은 그 좌석 전용 워크트리를 `-C`로 주고 `-s workspace-write`로 실행한다.
- `thermos reviewers`의 `codex:` 엔트리는 두 서브에이전트의 모델이 아니라 세 번째 리뷰어다. 같은 diff·컨텍스트와 함께 pstack 플러그인의 `skills/thermo-nuclear-review/SKILL.md`, `skills/thermo-nuclear-code-quality-review/SKILL.md` 경로를 주고 두 기준으로 모두 리뷰하게 한다. 두 서브에이전트의 모델은 그 줄의 Claude 엔트리를 쓴다.
- `codex:` 엔트리는 Claude와 다른 계열이라, cross-judge pool에 있으면 부모 계열 제외 규칙을 통과한다.
- 결과는 다른 좌석과 똑같이 판정·합성에 넣고, 보고할 때 출처를 엔트리 이름으로 표시한다.
- codex가 실패하거나 결과가 없으면 그 좌석을 빼고 진행하며 그렇다고 알린다.
- `/setup-pstack`은 감지된 모델만 쓰므로 `codex:` 엔트리를 지울 수 있다. 재실행 후 엔트리가 남았는지 확인한다.
