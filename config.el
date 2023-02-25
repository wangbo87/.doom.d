;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "wangbo87"
      user-mail-address "xunledelang@163.com")


(setq doom-font (font-spec :family "Source Code Pro" :size 14))
 (setq doom-font "Terminus (TTF):pixelsize=14:antialias=off")
  (setq doom-font "Source Code Pro-14")
;; (setq doom-unicode-font (font-spec :family "symbola" :size 20))
;; (setq doom-unicode-font (font-spec :family "DejaVu Sans" :size 15))
;; (setq doom-unicode-font (font-spec :family "quivira" :size 20))
(setq doom-unicode-font (font-spec :family "KaiTi" :size 14.0))
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;custourm;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(define-key global-map (kbd "<S-down-mouse-1>") 'ignore) ; turn off font dialog
;;(define-key global-map (kbd "<S-mouse-1>") 'mouse-set-point)
;;(put 'mouse-set-point 'CUA 'move)
;;(map! :g "C-s" #'save-buffer)
;;
;;(map! :g "<S-down-mouse-1>" #'ignore)
;;(map! :g "<S-mouse-1>" #'mouse-set-point)
;;(put 'mouse-set-point 'CUA 'move)
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;color-rg;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(modify-coding-system-alist 'process "rg" '(utf-8 . chinese-gbk-dos))
;;(custom-set-variables '(helm-ag-base-command "rg --vimgrep --no-heading --smart-case"))
(map! :g "C-s" #'save-buffer)
;; (global-set-key [f3] '+vertico/search-symbol-at-point)
(require 'color-rg)
(global-set-key [f2] 'color-rg-search-symbol-in-project)
(require 'helm-swoop)
(global-set-key (kbd "<f3>") 'helm-swoop)
(global-set-key [f4] 'helm-multi-swoop-all)

;; If there is no symbol at the cursor, use the last used words instead.
(setq helm-swoop-pre-input-function
      (lambda ()
        (let (($pre-input (thing-at-point 'symbol)))
          (if (eq (length $pre-input) 0)
              helm-swoop-pattern ;; this variable keeps the last used words
            $pre-input))))
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;verilog;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(require 'verilog-mode)

(setq verilog-tool "vlogan")
(setq verilog-linter "vlogan")
(setq verilog-coverage "vlogan")
(setq verilog-simulator "verdi")
(setq verilog-compiler "vlogan" )
;;插入
(define-skeleton insert-always-clk-rst
  "Inserts three comment lines, making a display comment."
  ()
  (interactive)
  (insert "always @(posedge clk or negedge rst_n) begin
      if(!rst_n)
      else
   end
  "))

  ;syn rst
  (defun insert-always-clk ()
	(interactive)
  (insert "always @(posedge clk) begin
      if( )
      else
   end
  "))

  (defun insert-xilinx-ram ()
	(interactive)
  (insert "
     ram_3x1024 ram_3x1024
     (
		// Outputs
		.doutb			  ( ram_rdata ),
		// Inputs
		.clka			  ( clk       ),
		.wea			  ( ram_wen   ),
		.addra			  ( ram_waddr ),
		.dina			  ( ram_wdata ),
		.clkb			  ( clk	      ),
		.enb			  ( ram_ren   ),
		.addrb			  ( ram_raddr ));

   always @(posedge clk) begin
      if(~rst_n)
        ram_wen <= 1'b0;
      else
        ram_wen <= 1'b1;
   end

   always @(posedge clk) begin
      if(~rst_n)
        ram_waddr <= 0;
      else if(ram_wen)
        ram_waddr <= ram_waddr+1'b1;
   end

   always @(posedge clk) begin
      if(~rst_n)
        ram_wdata <= 0;
      else
        ram_wdata <= {FPGA_RMII_TXEN,FPGA_RMII_TXD0,FPGA_RMII_TXD1};
   end
	  "))

  ;testbench
  (defun insert-testbench ()
	(interactive)
  (insert"`timescale 1ns / 100ps

module tb_ddc_top;
   parameter ClockPeriod = 10;
   parameter FRAM_LEN = 16'd16384;
   parameter FS_NUM = 8'd4;
   /*AUTOWIRE*/
   /*AUTOREGINPUT*/
   reg [07:00]          fs_cnt;
   reg [15:00]          cnt;
   reg [15:00]          mem_din_i[0:FRAM_LEN-1];
   reg [15:00]	        mem_din_q[0:FRAM_LEN-1];
   ddc_top ddc_top
     (/*AUTOINST*/);

   initial begin
      clk = 0;
      rst_n = 0;
   end

   always #(ClockPeriod/2) clk = ~clk;
   initial begin
      rst_n = 0;
      @(posedge clk);
      @(posedge clk);
      rst_n = 1;
   end

   always @(posedge clk) begin
      if(~rst_n)
        fs_cnt <= 0;
      else if(fs_cnt==FS_NUM-1)
        fs_cnt <= 0;
      else
        fs_cnt <= fs_cnt+1'b1;
   end

   always @(posedge clk) begin
      if(~rst_n)
        cnt <= 0;
      if(fs_cnt==FS_NUM-1) begin
         if(cnt==FRAM_LEN-1)
           cnt <= 0;
         else
           cnt <= cnt+1'b1;
      end
   end

   initial begin
      $readmemh(" ",mem_din_i);
      $readmemh(" ",mem_din_q);
   end

   always @(posedge clk) begin
      if(~rst_n)
        din_vld <= 1'b0;
      else if(fs_cnt==FS_NUM-1)
        din_vld <= 1'b1;
      else
        din_vld <= 1'b0;
   end

   assign din_i = mem_din_i[cnt];
   assign din_q = mem_din_q[cnt];

endmodule
	"))

(defun insert-inst-my ()
	(interactive)
  (insert "
modu_name modu_name
(/*autoinst*/);
	  "))

  (defun insert-fsm ()
  (interactive)
  (insert "
parameter IDLE = 4'd1,
RRAM = 4'd2,
WRAM = 4'd4,
aaa = 4'd8;

assign is_idle = state[0];
assign is_idle = state[0];
assign is_idle = state[0];
assign is_idle = state[0];

always @(posedge clk or negedge rst_n) begin
      if(!rst_n)
         state <= IDLE;
      else
         state <= nx_state;
   end

always @ * begin

end
  "))

;; (map! :g "C-c C-1" #'verilog-sk-module)
(defun wb-verilog-mode ()
  (local-set-key (kbd "C-1      ") 'insert-always-clk-rst)
  (local-set-key (kbd "C-2      ") 'insert-always-clk)
  (local-set-key (kbd "C-c C-f") 'insert-fsm)
  (local-set-key (kbd "C-c C-i") 'insert-inst-my )
  (local-set-key (kbd "C-c C-t") 'insert-testbench )
  (local-set-key (kbd "C-c C-m") 'verilog-sk-module)
  (local-set-key (kbd "[f9]     ") 'verilog-insert-date))

(add-hook 'verilog-mode-hook 'wb-verilog-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;corfu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (advice-add #'company-mode :override '(lambda (x) (message "disabled company-mode")))
;; ;;Enable auto completion and configure quitting
;;   (setq corfu-auto t
;;         corfu-quit-no-match 'separator) ;; or t

(when (modulep! :completion company)
  (setq +lsp-company-backends '(company-capf :with company-yasnippet)))

