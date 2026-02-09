{ config, pkgs, ... }:

{
  # 启用 zsh
  programs.zsh.enable = true;
  
  # 设置默认 shell
  users.users.Qaaxaap = {
    shell = pkgs.zsh;
  };
  
  # 允许系统使用 zsh
  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  # 通过 home-manager 配置用户 zsh
  home-manager.users.Qaaxaap = { pkgs, ... }: {
    home.file.".p10k.zsh".source = ./p10k.zsh;
    home.packages = with pkgs; [
      zsh-powerlevel10k
    ];
    
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "";
      };
      
      initContent = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };
    
  };
}
