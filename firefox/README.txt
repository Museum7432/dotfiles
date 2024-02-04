clone https://github.com/andreasgrafen/cascade.git to ./chrome/base/cascade

and remove or comment out these lines in  cascade/chrome/includes/cascade-config.css

#identity-permission-box { display: none !important; }

#page-action-buttons > :not(#urlbar-zoom-button) { display: none !important; }

#unified-extensions-button { display: none !important; }

-#back-button,
-#forward-button { display: none !important; }