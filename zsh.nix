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
  
  # 通过 home-manager 配置用户 zsh
  home-manager.users.Qaaxaap = { pkgs, ... }: {
    home.packages = with pkgs; [
      zsh-powerlevel10k
    ];
    
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "";
      };
      
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };
    
    home.file.".p10k.zsh".text = builtins.readFile (./. + "/p10k.zsh");
  };
}
