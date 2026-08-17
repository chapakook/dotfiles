# dotfiles

macOS 초기 설정 자동화 스크립트

## 포함된 설정

### GUI 앱 (brew cask)
- Ghostty, Google Chrome, Discord, Slack, Zoom, Figma, Claude

### 폰트 (brew cask)
- Meslo LG Nerd Font

### CLI 도구 (brew)
- tmux, powerlevel10k, bat, zsh-autosuggestions
- fzf, zoxide, eza, lazygit, btop
- neovim, fd, ripgrep, node
- Herdr, Bun, Tailscale
- Oh My Zsh, TPM (Tmux Plugin Manager)

### CLI 도구 (npm 전역)
- Claude Code (`@anthropic-ai/claude-code`)
- Codex (`@openai/codex`)
- brew cask보다 버전 업데이트가 빨라 npm으로 설치

### 설정 파일
- `preferences/zsh/` - zsh, powerlevel10k 설정
- `preferences/tmux/` - tmux 설정
- `preferences/ghostty/` - Ghostty 설정
- `preferences/nvim/` - Neovim (LazyVim) 설정
- `preferences/claude/` - Claude Code 설정
- `preferences/.ideavimrc` - IdeaVim 설정

### 에이전트 워크스페이스
- Herdr - Claude Code/Codex 세션을 관리하는 터미널 멀티플렉서
- Claude Code/Codex 공식 Herdr 통합 - 세션 복원 지원
- Collie - Tailscale을 통한 Herdr 모바일 PWA
- herdr-file-viewer - Herdr 워크스페이스 파일 뷰어 플러그인

## 사용법

### 전체 설치 (새 맥북)
```bash
git clone https://github.com/d3v1n8/dotfiles.git
cd dotfiles
./init.sh
```

### 부분 실행
```bash
./init.sh all          # 전체 설치 (기본값)
./init.sh brew         # Homebrew만 설치
./init.sh apps         # GUI 앱만 설치
./init.sh cli          # CLI 도구만 설치
./init.sh herdr        # Herdr 통합 및 플러그인 설치
./init.sh collie       # Collie 설치 및 Tailscale 연결
./init.sh link         # 전체 설정 파일 링크
./init.sh link:ghostty # Ghostty 설정 리셋
./init.sh link:zshrc   # zshrc 설정 리셋
./init.sh link:ideavim # ideaVim 설정 리셋
./init.sh link:tmux    # tmux 설정 리셋
./init.sh link:claude  # Claude 설정 리셋
./init.sh link:nvim    # Neovim (LazyVim) 설정 리셋
./init.sh help         # 도움말
```

인자 없이 실행하면 인터랙티브 메뉴가 표시됩니다.

### Herdr + Collie
```bash
./init.sh herdr
herdr                  # Herdr 서버 최초 실행
./init.sh collie       # Collie 시작 및 Tailscale 연결
```

`./init.sh all`은 herdr 통합과 플러그인 설치(`setup_herdr`)까지만 진행합니다. Collie의 Tailscale 원격 노출은 기본 설치에 포함되지 않으며, `./init.sh collie`를 직접 실행할 때만 구성됩니다.

Tailscale Serve를 처음 사용하는 Tailnet은 출력되는 승인 URL에서 기능을 한 번 활성화해야 합니다. 승인 후 `./init.sh collie`를 다시 실행하면 Tailnet 전용 HTTPS 주소가 생성됩니다.

Collie는 원격에서 현재 사용자 권한으로 터미널을 제어할 수 있습니다. 설정 스크립트는 다음 제한을 기본 적용합니다.

- `127.0.0.1`에만 바인딩
- 현재 Tailscale 사용자만 허용
- 현재 Mac의 MagicDNS 호스트만 허용
- 기본 Herdr 세션만 공개
- `tailscale serve`만 사용하며 public Funnel은 사용하지 않음

Herdr 마켓플레이스는 자동 수집되는 커뮤니티 목록이며 검수된 카탈로그가 아닙니다. 기본 셋업은 공식 Claude/Codex 통합과 직접 검토한 커뮤니티 플러그인(Collie, herdr-file-viewer)만 설치합니다. 다른 플러그인은 소스와 권한을 확인한 뒤 개별적으로 추가하세요.

### 설치 후 추가 작업
1. 터미널 재시작하여 zsh/p10k 설정 적용
2. Ghostty에서 `Cmd+Shift+,`를 눌러 설정 다시 로드
3. tmux 실행 후 `prefix + I`로 플러그인 설치
