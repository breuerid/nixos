{
 description = "NixOS-configuratie van David W. Breuer";
 
 inputs = {
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
 };

 outputs = { self, nixpkgs }: {
   nixosConfigurations.sensei = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./hosts/sensei/configuration.nix ];
   };
 };
}

