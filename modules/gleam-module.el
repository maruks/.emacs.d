;; gleam-module

(require 'package-module)

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp"))))

;; M-x gleam-ts-install-grammar

(use-package gleam-ts-mode
  :mode (rx ".gleam" eos)
  :hook ((gleam-ts-mode . eglot-ensure))
  :config
  (projectile-register-project-type 'gleam-ts '("gleam.toml")
                                    :project-file "gleam.toml"
				    :compile "gleam build"
				    :test "gleam test"
				    :run "gleam run"
                                    :src-dir "src/"
                                    :test-dir "test/"
				    :test-suffix "_test"))

(provide 'gleam-module)
