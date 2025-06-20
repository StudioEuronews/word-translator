// Fichier d'exemple de configuration
// Copiez ce fichier vers config.js et remplissez vos vraies clés

const CONFIG = {
    // 🔑 Vos clés Azure Translator (à récupérer depuis le portail Azure)
    AZURE_API_KEY: 'VOTRE_CLE_AZURE_ICI',     // Remplacez par votre Clé 1 ou Clé 2
    AZURE_REGION: 'westeurope',                // Remplacez par votre région (ex: westeurope, eastus)
    
    // ⚙️ Configuration optionnelle
    ENABLE_AZURE: true,     // true = utilise Azure, false = utilise seulement MyMemory
    DEBUG_MODE: false,      // true = affiche les logs détaillés dans la console
    
    // 🛡️ Protection contre les coûts excessifs
    MAX_CHARACTERS: 5000    // Limite maximale de caractères par traduction
};

// 📝 Instructions :
// 1. Copiez ce fichier vers config.js
// 2. Remplacez VOTRE_CLE_AZURE_ICI par votre vraie clé Azure
// 3. Mettez à jour AZURE_REGION si nécessaire
// 4. Ne committez JAMAIS config.js dans Git !

function validateConfig() {
    if (CONFIG.AZURE_API_KEY === 'VOTRE_CLE_AZURE_ICI') {
        console.warn('⚠️ Azure API key not configured. Using fallback translation service.');
        CONFIG.ENABLE_AZURE = false;
    }
    
    if (CONFIG.DEBUG_MODE) {
        console.log('🔧 Debug mode enabled');
        console.log('🔑 Azure enabled:', CONFIG.ENABLE_AZURE);
        console.log('🌍 Region:', CONFIG.AZURE_REGION);
    }
}

validateConfig();
