(local lazy (require :lazy))

(lazy.setup [{:url :aileot/nvim-thyme
              :version "^v1.7.0"
              :lazy false
              :dependencies ["https://git.sr.ht/~technomancy/fennel"]}
             {:url :aileot/nvim-laurel
              :version "^v0.7.7"
              :lazy false}
             {:url :eraserhd/parinfer-rust
              :event "VeryLazy"}
             {:import :plugins}
             {:import :plugins_fnl}]
            {:defaults {:lazy true}
             :performance {:rtp {:reset false
                                 :disabled_plugins [:gzip
                                                    :netrwPlugin
                                                    :rplugin
                                                    :tarPlugin
                                                    :tohtml
                                                    :tutor
                                                    :zipPlugin]}}})

