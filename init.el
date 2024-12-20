;; clm/open-command-log-buffer C-c o
;; evll C-c C-e

;; Initialize package sources
(require 'package)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(package-initialize)
(setq use-package-always-ensure t)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)
(setq use-package-always-ensure t)
















;; 优先加载 my-priority-file.el
(load "~/.emacs.d/lisp/priority-file.el")

;; 然后加载其他 .el 文件
(dolist (file (directory-files "~/.emacs.d/lisp/" t "\\.el$"))
  (unless (string= file "~/.emacs.d/lisp/priority-file.el")
    (load file)))






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f8abe1fe632952b0fd198907f817accef48bd313fc6ec7ba2470953fcb483a87" "0d5a083423dfee48899b63212fc10eec7249f476d17c686f64f826cf61e566e1" "0bc49a65bbc66fde922d08bd73b3068e7763cc98bf83a74dcbf0c66416e720fc" "716d3161d37259533ee96fc63d4dce5d323e835d89438336f193f6dcf2163ba5" "af56c8f8b05edff834e83f94727d1ffb696304b628b827d580e1d92d97fd3858" "7db04ec97febeb281a38b64b1d492aae15b7e91df22231037b4893c450ac8149" "a707b3c5c02a8b31688a82125a4ce45d3f45514bcdaf1c8ac62b3473358d760a" "cdbcb11dca2427187cb7a91e17ac12b337e1f75efbefd578b5829cef09d6edc4" "ec2c86933a6e0b96f68f71d4b39ebdd67b43b0b32091b7689acb9acdc2a3e03b" "6b234feec8db588ad5ec2a9d9d7b935f7a155104b25ccfb94d921c45a2ff7d22" "ff94bc11cb1ddef83cfdf87c2079b80182c00d50f42184c2a6f61de6773652e6" "bfa1b17026b2d86264172dd7064083460e1349f86f933d9853a0fb209b6c9448" "10077e988cef1b336665e225ae8f7285c0134b90baa6369ee171274f99aa1dd6" "1879ec1b394d6af5869c4899ebf60ae22537e9092f75cdc75dacff861a7d1050" "17eaed2e460954d7a850d8f3c20bb61e4f37034172169e72f1c6d528b587f82b" "e5279f5056ff6ef3cb74333ef317ad1d8790a3ef599f5673144ab6d56d1d5d94" "97681d7feca38cc3a629a563e812a372778454729d1508761799fb13347bad93" "6f680a28855e47b13cfb39d933dab8848bb0d80be237e0b2d6be6293f1f38a13" "5fe0df778c929fbb84319e35d77c99c72b49080aad53851bd5e4584cb69174e1" "72eb0ff8e2a1f227002b5cdc4284f86f147e8dc51f763b7fb96d6e59d4d2dbd8" "95ebf5b5e0e65d2985bd6243a4747a11b8c271a6d632b4c83aadfe69c38ecfaa" "619beec7b0b2986c3b3517a8ae632167022388b9b397ec5f65af3388304239d4" "2ba52d3cf6f138ca570d80c791b96341d44a763e1057562aea7114fe95c8e307" "074444920c5a8b7be68b78a5f94d822fedcca27874b8c8e4cd5cebb1d37125cd" "2ed177de0dfc32a6a32d6109ddfd1782a61bcc23916b7b967fa212666d1aa95c" "81eedac030249f826681ab768953f5b0f671d4b069bd6c9c486f762644b24d7c" "4ed20d30a768c1a9032cf63aa8980723c21589c68838cd972f79e7ca2a414b9d" "390af3f30c5d5b76739983cf8b85c8bbd04a46ac1488b11d150dec565ba82f55" "8f13c9ecfd58bb55996d061680fe7f9cc67357910b78c71e28ffb14dd5bdd89c" "e68eaf58e7c85d4b0c76cd533602a5ede42af6892909dae366456c92c3afb615" "df075d47b9c99ee543272778d5c18ca69d5253fd8c2c8d5d9d3d2d02ae18431f" "180821795742c64e155841e8f9351b9d818e865d79dfc72f1aeab16b8724c9e4" "4415de264eae37617b1a287b2af8cafb8e087379767c252ff39d6bae27712856" "726cc04cc9fa72a47adfe822dff11a367fa7ca853b6204a5758b48c9af37f51e" "0f1da577aee469f092b24417fe8c13d0b5b76c40c8e4484ff40c609d8da61f69" "5912c255e7e46432d6c1c057a2124cce807ad4b901a99bc43e838db0754dff91" "d0e166972a0a8cdd4e91e4b5a040ef429c733f1bf4f4117351bf12b7a8967a59" "d2a14f85e1ba5b28433b96e4628444a4c6a2334368ddc2d568b06eb631492681" "c37cf0c1e318ba0a40cb1d39902b4941b64c7063a0a7282a45f534185567841d" "0a2168af143fb09b67e4ea2a7cef857e8a7dad0ba3726b500c6a579775129635" "368ff345ec3caf52bb4f4c4891d9246824b029ab61d1e227153ef8ca0b19a7b2" "616671c6ce7f7bf8efed89a65f393078ad96f74f9a7f2e524a88065c500fd6bb" "cd322dc37af17c4e122c99c93fe1a423dd1407797fe51d2278fc25c60a46be45" "28cf1f7cc54ab4ee1ba4a4644046bd661941be92ef8327af56909f340cb9d3d5" "8cc5fbb8e8dcf9d30f565b87fbe94f5d5c460ddebbf0bdc15e23ad5222ea2578" "d425e2488aee5a2f71abc4a49b1854423dd62575a3529f28aed55eb32190992c" "a8021746a98a8147069ce4f31e14368c4e7dcf334fe1adff1408b4590d15fb4d" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "1b27e3b3fce73b72725f3f7f040fd03081b576b1ce8bbdfcb0212920aec190ad" "255fd4dce8b1adcdf9dfaef6f847340e8062a1e2568c51fedeb962778d130773" "8d5f22f7dfd3b2e4fc2f2da46ee71065a9474d0ac726b98f647bc3c7e39f2819" "f2e885fc2a2d9bf2ca730058c2ebb835ba87e98df18ef9fc5c0f143a619d4c10" "0cd56f8cd78d12fc6ead32915e1c4963ba2039890700458c13e12038ec40f6f5" "a96c80b229f3605f1c7171cf109944be284f8dca58a5384a20e9320a6e19eb8c" "9635554c44541b94c009835d43bab46c760a883d4b4ef10c9e49323c62d47d47" "6587cc658fcc2ef21134f46f0c1fa91ca2814a50650fcfd5aa2d02262bf119a1" "864254fee8fb202fc23e61dae31e1ca86f2b7eb4ea4a2154038e216423919168" "01f9cd70f7741dc1c6c0e7f35d0bff6203b46fa9127d60fd82a481af012f1854" "2b474647799a29add7e3cf34cd9f8178e872f6a4f354f58f4e717d93a53a4eed" "a94f1a015878c5f00afab321e4fef124b2fc3b823c8ddd89d360d710fc2bddfc" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(evil-numbers evil-surround evil-collection evil-commentary evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-file ((t (:foreground "lightgreen"))))
 '(helm-candidate-number ((t (:foreground "cyan"))))
 '(helm-header ((t (:background "gray30" :foreground "white"))))
 '(helm-match ((t (:background "yellow" :foreground "red"))))
 '(helm-selection ((t (:background "lightblue" :foreground "black"))))
 '(helm-visible-mark ((t (:background "green" :foreground "black")))))
