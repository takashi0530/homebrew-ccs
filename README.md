# ccs — Claude Code Session Switcher

Browse, search, and resume **all** your [Claude Code](https://claude.com/claude-code) sessions across every project directory — with an fzf-powered picker.

Claude Code stores each session under `~/.claude/projects/<encoded-launch-directory>/`, and the built-in `/resume` only lists sessions for the directory you launched from. `ccs` scans them all, lets you pick one, then `cd`s to the right directory and runs `claude --resume <id>` for you.

```
$ ccs
  2026-07-07 13:18  ★ my-api (29msg/1.1MB)                    ~/dev/my-api/backend
  2026-07-07 13:18  ★ notes app (3msg/492KB)                                     ~
  2026-07-07 12:47  ★ video-tool (58msg/3.3MB)             ~/dev/video-tool/backend
> 2026-07-05 20:19  fix the login bug… (6msg/56KB)               ~/dev/webapp
  ── 直近のユーザー発言 ──────────────────────────────────────────
  (preview of the session's recent user messages)
```

## Features

- **Cross-project listing** — every session on the machine, newest first, path right-aligned
- **Full-text search** — `ccs -g "keyword"` greps inside conversation transcripts, not just titles
- **Named sessions always visible** — sessions you `/rename` inside Claude Code show up with a cyan ★ and are never hidden by filters or list limits
- **Resume with a permission mode** — `Enter` = normal, `Ctrl-A` = `--permission-mode acceptEdits`, `Ctrl-X` = `--dangerously-skip-permissions`
- **Backup** — `ccs backup` copies all session files out of reach of Claude Code's automatic cleanup (30 days by default)
- **Noise filtering** — hide tiny/abandoned unnamed sessions via config
- Works without fzf too (falls back to a numbered menu)

## Install

```bash
brew tap takashi0530/ccs
brew install ccs
```

> **Homebrew 5.0+ tap trust**
> On Homebrew 5.0 and later, third-party taps must be trusted before their formulae can be installed. If `brew install` fails with `Refusing to load formula ... from untrusted tap`, run:
>
> ```bash
> brew trust takashi0530/ccs   # trust the whole tap, then re-run brew install ccs
> ```
>
> Or trust just this formula (narrower): `brew trust --formula takashi0530/ccs/ccs`.

Or manually: copy `ccs` somewhere on your `PATH` and `chmod +x` it. Requires `bash`, `jq`, and (recommended) `fzf` ≥ 0.34.

## Usage

```bash
ccs                # pick a session (↑↓ + type to filter), Enter to resume
ccs 動画           # start with a filter query
ccs -g "OAuth"     # full-text search inside transcripts
ccs -l             # list only, don't resume
ccs --days 7       # sessions from the last 7 days
ccs --cwd          # sessions related to the current directory
ccs -m skip        # resume with --dangerously-skip-permissions
ccs backup         # snapshot all sessions to ~/.claude-session-backups
ccs config         # interactive settings (or: ccs config max 200 / ccs config edit)
ccs help           # full help
```

### Keys in the picker

| Key | Action |
|---|---|
| `↑` `↓` / type | select / filter |
| `Enter` | resume (normal permissions) |
| `Ctrl-A` | resume with `--permission-mode acceptEdits` |
| `Ctrl-X` | resume with `--dangerously-skip-permissions` |
| `Esc` | cancel |

### Config (`~/.config/ccs/config`)

| Key | Default | Meaning |
|---|---|---|
| `CCS_MAX` | 100 | max rows listed (named ★ sessions are always shown) |
| `CCS_MIN_KB` | 0 | hide unnamed sessions smaller than this |
| `CCS_MIN_MSGS` | 0 | hide unnamed sessions with fewer user messages |
| `CCS_EXCLUDE` | — | regex; hide sessions whose title matches |
| `CCS_BACKUP_DIR` | `~/.claude-session-backups` | `ccs backup` destination |

Filters apply to **unnamed** sessions only — anything you `/rename` inside Claude Code is always listed. Environment variables override the file per-invocation (`CCS_MAX=300 ccs`).

## Caveats

- `ccs` reads Claude Code's **undocumented internal files** (`~/.claude/projects/**/*.jsonl`, `~/.claude/history.jsonl`). A Claude Code update may break it at any time. It only ever *reads* session data (plus a copy for `backup`), so it cannot corrupt your history.
- Recent Claude Code builds have `Ctrl-A` inside `/resume` to widen the picker to all projects; `ccs` still adds full-text search, permission-mode selection, filtering, and backup on top.
- UI messages are currently Japanese. PRs for i18n are welcome.

---

# 日本語ドキュメント

[Claude Code](https://claude.com/claude-code) の全セッションを**プロジェクト横断**で一覧・検索・再開するツールです。

Claude Code はセッションを「claude を起動したディレクトリ」ごとに `~/.claude/projects/` 配下へ保存するため、別の場所で `/resume` しても一覧に出てきません（「あのセッションどこ行った？」の原因）。`ccs` は全ディレクトリを横断して一覧・検索し、選ぶと**正しいディレクトリへ cd してから `claude --resume` を実行**するところまで自動で行います。

## 特徴

- **全プロジェクト横断の一覧** — マシン上の全セッションを新しい順に表示（パスは右端に整列）
- **本文の全文検索** — `ccs -g キーワード` でタイトルだけでなく会話の中身まで検索
- **名前付きセッションは絶対に消えない** — Claude Code 内で `/rename` したセッションは ★ 付きシアンで強調され、フィルタや件数上限に関係なく常に表示
- **権限モードを選んで再開** — `Enter` = 通常 / `Ctrl-A` = 編集自動許可 / `Ctrl-X` = dangerously-skip
- **バックアップ** — `ccs backup` で自動削除（既定30日）に備えて全セッションを退避
- **ノイズ除去** — 「あ」だけ打って放置したような無名セッションを設定で非表示にできる
- fzf がない環境では番号選択メニューに自動フォールバック

## インストール

```bash
brew tap takashi0530/ccs
brew install ccs
```

> **Homebrew 5.0 以降の tap 信頼について**
> Homebrew 5.0 以降では、サードパーティ tap のフォーミュラをインストールする前に「信頼」する必要があります。`brew install` が `Refusing to load formula ... from untrusted tap` で失敗した場合は、次を実行してから `brew install ccs` をやり直してください。
>
> ```bash
> brew trust takashi0530/ccs   # この tap 全体を信頼 → brew install ccs を再実行
> ```
>
> このフォーミュラだけを信頼する（より限定的）場合: `brew trust --formula takashi0530/ccs/ccs`

手動の場合: `ccs` を PATH の通った場所に置いて `chmod +x`。必要なもの: `bash` / `jq` / `fzf` 0.34以上（推奨）。

## 使い方

```bash
ccs                # 一覧を開く（↑↓で選択、文字入力で絞り込み）→ Enter で再開
ccs 動画           # 最初からキーワードで絞り込み
ccs -g "OAuth"     # 会話本文まで全文検索
ccs -l             # 一覧表示のみ（再開しない）
ccs --days 7       # 直近7日のセッションのみ
ccs --cwd          # 今いるディレクトリに関係するもののみ
ccs -m skip        # dangerously-skip-permissions で再開
ccs backup         # 全セッションを ~/.claude-session-backups に退避
ccs config         # 設定（対話式。ccs config max 200 の一発指定や ccs config edit も可）
ccs help           # ヘルプ
```

### 選択画面のキー操作

| キー | 動作 |
|---|---|
| `↑` `↓` / 文字入力 | 選択 / 絞り込み |
| `Enter` | 通常モードで再開 |
| `Ctrl-A` | `--permission-mode acceptEdits`（編集自動許可）で再開 |
| `Ctrl-X` | `--dangerously-skip-permissions` で再開 |
| `Esc` | キャンセル |

### 設定（`~/.config/ccs/config`）

| キー | 既定値 | 意味 |
|---|---|---|
| `CCS_MAX` | 100 | 一覧の最大件数（★名前付きは上限の対象外） |
| `CCS_MIN_KB` | 0 | このKB未満の無名セッションを非表示 |
| `CCS_MIN_MSGS` | 0 | ユーザー発言数がこれ未満の無名セッションを非表示 |
| `CCS_EXCLUDE` | — | タイトルがこの正規表現に一致したら非表示 |
| `CCS_BACKUP_DIR` | `~/.claude-session-backups` | `ccs backup` の保存先 |

フィルタが効くのは**無名セッションのみ**です。`/rename` で名前を付けたセッションは必ず表示されます。環境変数で一時上書きもできます（`CCS_MAX=300 ccs`）。

## 注意事項

- `ccs` は Claude Code の**非公式な内部ファイル**（`~/.claude/projects/**/*.jsonl` 等）を読んでいます。Claude Code の更新で動かなくなる可能性があります。セッションデータへの書き込みは一切しない（backup のコピーを除く）ので、履歴を壊すことはありません。
- 最近の Claude Code には `/resume` 画面で `Ctrl-A` を押すと全プロジェクトに広げる機能があります。`ccs` はその上に全文検索・権限モード選択・フィルタ・バックアップを足したものです。

## License

[MIT](LICENSE)
