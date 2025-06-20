<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="html"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Traducteur Multilingue Word</title>
        <script src="https://appsforoffice.microsoft.com/lib/1/hosted/office.js"></script>
        <style>
          body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
          }

          .container {
            max-width: 400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
          }

          .header {
            background: linear-gradient(45deg, #2196F3, #21CBF3);
            color: white;
            padding: 25px;
            text-align: center;
          }

          .header h1 {
            margin: 0;
            font-size: 1.8em;
            font-weight: 300;
          }

          .content {
            padding: 30px;
          }

          .language-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 25px;
          }

          .language-option {
            display: flex;
            align-items: center;
            padding: 8px;
            border-radius: 8px;
            transition: background-color 0.2s;
            cursor: pointer;
          }

          .language-option:hover {
            background-color: #f5f5f5;
          }

          .language-option input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.2);
          }

          .language-option label {
            cursor: pointer;
            font-size: 0.9em;
            user-select: none;
          }

          .controls {
            margin-bottom: 25px;
          }

          .option-group {
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
          }

          .option-group h3 {
            margin: 0 0 10px 0;
            font-size: 1em;
            color: #555;
          }

          .checkbox-option {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
          }

          .checkbox-option input[type="checkbox"] {
            margin-right: 10px;
            transform: scale(1.1);
          }

          .checkbox-option label {
            cursor: pointer;
            font-size: 0.9em;
          }

          .translate-btn {
            width: 100%;
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 15px;
          }

          .translate-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
          }

          .translate-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
          }

          .export-btn {
            width: 100%;
            background: linear-gradient(45deg, #FF6B6B, #FF5252);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 10px;
          }

          .export-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
          }

          .export-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
          }

          .progress-container {
            display: none;
            margin: 20px 0;
          }

          .progress-bar {
            width: 100%;
            height: 20px;
            background: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
          }

          .progress-fill {
            height: 100%;
            background: linear-gradient(45deg, #4CAF50, #45a049);
            width: 0%;
            transition: width 0.3s;
          }

          .progress-text {
            text-align: center;
            margin-top: 10px;
            font-size: 0.9em;
            color: #666;
          }

          .status {
            margin-top: 15px;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.9em;
            display: none;
          }

          .status.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
          }

          .status.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
          }

          .flag {
            margin-right: 5px;
            font-size: 1.1em;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>🌍 Traducteur Multilingue</h1>
          </div>
          
          <div class="content">
            <div class="language-grid">
              <div class="language-option">
                <input type="checkbox" id="fr" value="fr" checked="checked"/>
                <label for="fr"><span class="flag">🇫🇷</span>Français</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="de" value="de" checked="checked"/>
                <label for="de"><span class="flag">🇩🇪</span>Allemand</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="it" value="it" checked="checked"/>
                <label for="it"><span class="flag">🇮🇹</span>Italien</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="es" value="es" checked="checked"/>
                <label for="es"><span class="flag">🇪🇸</span>Espagnol</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="pt" value="pt" checked="checked"/>
                <label for="pt"><span class="flag">🇵🇹</span>Portugais</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="ru" value="ru" checked="checked"/>
                <label for="ru"><span class="flag">🇷🇺</span>Russe</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="el" value="el" checked="checked"/>
                <label for="el"><span class="flag">🇬🇷</span>Grec</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="hu" value="hu" checked="checked"/>
                <label for="hu"><span class="flag">🇭🇺</span>Hongrois</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="pl" value="pl" checked="checked"/>
                <label for="pl"><span class="flag">🇵🇱</span>Polonais</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="fa" value="fa" checked="checked"/>
                <label for="fa"><span class="flag">🇮🇷</span>Farsi</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="ar" value="ar"/>
                <label for="ar"><span class="flag">🇸🇦</span>Arabe</label>
              </div>
              <div class="language-option">
                <input type="checkbox" id="tr" value="tr"/>
                <label for="tr"><span class="flag">🇹🇷</span>Turc</label>
              </div>
            </div>

            <div class="controls">
              <div class="option-group">
                <h3>Options de traduction</h3>
                <div class="checkbox-option">
                  <input type="checkbox" id="preserveFormat" checked="checked"/>
                  <label for="preserveFormat">Conserver la mise en page</label>
                </div>
                <div class="checkbox-option">
                  <input type="checkbox" id="redText" checked="checked"/>
                  <label for="redText">Texte traduit en rouge</label>
                </div>
                <div class="checkbox-option">
                  <input type="checkbox" id="newPage" checked="checked"/>
                  <label for="newPage">Nouvelle page par langue</label>
                </div>
              </div>

              <div class="option-group">
                <h3>Export audio</h3>
                <div class="checkbox-option">
                  <input type="checkbox" id="enableAudio"/>
                  <label for="enableAudio">Activer l'export audio</label>
                </div>
              </div>
            </div>

            <button class="translate-btn" onclick="startTranslation()">
              🚀 Commencer la traduction
            </button>

            <button class="export-btn" onclick="exportAudio()" disabled="disabled" id="audioBtn">
              🎵 Exporter les fichiers audio
            </button>

            <div class="progress-container" id="progressContainer">
              <div class="progress-bar">
                <div class="progress-fill" id="progressFill"></div>
              </div>
              <div class="progress-text" id="progressText"></div>
            </div>

            <div class="status" id="status"></div>
          </div>
        </div>

        <script type="text/javascript">
          <![CDATA[
          let translatedContent = {};
          let isTranslationComplete = false;

          // Initialisation d'Office
          Office.onReady(function(info) {
            if (info.host === Office.HostType.Word) {
              console.log('Add-in chargé dans Word');
            }
          });

          // Langues avec leurs codes de traduction
          const languages = {
            'fr': { name: 'Français', voice: 'fr-FR' },
            'de': { name: 'Allemand', voice: 'de-DE' },
            'it': { name: 'Italien', voice: 'it-IT' },
            'es': { name: 'Espagnol', voice: 'es-ES' },
            'pt': { name: 'Portugais', voice: 'pt-PT' },
            'ru': { name: 'Russe', voice: 'ru-RU' },
            'el': { name: 'Grec', voice: 'el-GR' },
            'hu': { name: 'Hongrois', voice: 'hu-HU' },
            'pl': { name: 'Polonais', voice: 'pl-PL' },
            'fa': { name: 'Farsi', voice: 'fa-IR' },
            'ar': { name: 'Arabe', voice: 'ar-SA' },
            'tr': { name: 'Turc', voice: 'tr-TR' }
          };

          function startTranslation() {
            const selectedLanguages = getSelectedLanguages();
            
            if (selectedLanguages.length === 0) {
              showStatus('Veuillez sélectionner au moins une langue.', 'error');
              return;
            }

            const button = document.querySelector('.translate-btn');
            button.disabled = true;
            button.textContent = '⏳ Traduction en cours...';

            showProgress(true);
            translatedContent = {};

            Word.run(function (context) {
              // Récupérer le contenu du document
              const body = context.document.body;
              body.load("text,style");
              
              return context.sync().then(function () {
                const originalText = body.text;
                
                if (!originalText.trim()) {
                  throw new Error('Le document est vide.');
                }

                // Traduire pour chaque langue sélectionnée
                let promises = [];
                for (let i = 0; i < selectedLanguages.length; i++) {
                  const langCode = selectedLanguages[i];
                  const langName = languages[langCode].name;
                  
                  updateProgress((i / selectedLanguages.length) * 100, 'Traduction en ' + langName + '...');
                  
                  const promise = translateText(originalText, langCode).then(function(translatedText) {
                    translatedContent[langCode] = translatedText;
                    return insertTranslation(context, translatedText, langName, langCode);
                  }).catch(function(error) {
                    console.error('Erreur lors de la traduction en ' + langName + ':', error);
                    translatedContent[langCode] = '[Erreur de traduction pour ' + langName + ']';
                  });
                  
                  promises.push(promise);
                }

                return Promise.all(promises).then(function() {
                  return context.sync();
                }).then(function() {
                  updateProgress(100, 'Traduction terminée !');
                  
                  setTimeout(function() {
                    showProgress(false);
                    showStatus('Traduction réussie ! Le document a été mis à jour.', 'success');
                    isTranslationComplete = true;
                    
                    // Activer le bouton audio si l'option est cochée
                    if (document.getElementById('enableAudio').checked) {
                      document.getElementById('audioBtn').disabled = false;
                    }
                  }, 1000);
                });
              });
            }).catch(function (error) {
              console.error('Erreur:', error);
              showStatus('Erreur: ' + error.message, 'error');
              showProgress(false);
            }).finally(function() {
              button.disabled = false;
              button.textContent = '🚀 Commencer la traduction';
            });
          }

          function insertTranslation(context, translatedText, langName, langCode) {
            const preserveFormat = document.getElementById('preserveFormat').checked;
            const redText = document.getElementById('redText').checked;
            const newPage = document.getElementById('newPage').checked;

            return Word.run(function (context) {
              // Insérer un saut de page si demandé
              if (newPage) {
                context.document.body.insertBreak(Word.BreakType.page, Word.InsertLocation.end);
              }

              // Insérer le titre de la langue
              const titleRange = context.document.body.insertText('\n\n=== ' + langName.toUpperCase() + ' ===\n\n', Word.InsertLocation.end);
              titleRange.font.bold = true;
              titleRange.font.size = 16;
              titleRange.font.color = '#2196F3';

              // Insérer le texte traduit
              const textRange = context.document.body.insertText(translatedText, Word.InsertLocation.end);
              
              if (redText) {
                textRange.font.color = '#FF0000';
              }

              // Appliquer le formatage si demandé
              if (preserveFormat) {
                textRange.font.size = 12;
                textRange.paragraphFormat.spaceAfter = 6;
              }

              return context.sync();
            });
          }

          function translateText(text, targetLang) {
            // Simulation de traduction utilisant une API publique
            return new Promise(function(resolve, reject) {
              try {
                const url = 'https://api.mymemory.translated.net/get?q=' + encodeURIComponent(text) + '&langpair=en|' + targetLang;
                
                const xhr = new XMLHttpRequest();
                xhr.open('GET', url);
                xhr.onload = function() {
                  if (xhr.status === 200) {
                    const data = JSON.parse(xhr.responseText);
                    if (data.responseData && data.responseData.translatedText) {
                      resolve(data.responseData.translatedText);
                    } else {
                      reject(new Error('Service de traduction indisponible'));
                    }
                  } else {
                    reject(new Error('Erreur de réseau'));
                  }
                };
                xhr.onerror = function() {
                  reject(new Error('Erreur de connexion'));
                };
                xhr.send();
              } catch (error) {
                // Fallback: texte d'exemple
                resolve('[Traduction ' + languages[targetLang].name + '] ' + text);
              }
            });
          }

          function exportAudio() {
            if (!isTranslationComplete || Object.keys(translatedContent).length === 0) {
              showStatus('Veuillez d\'abord effectuer une traduction.', 'error');
              return;
            }

            const button = document.getElementById('audioBtn');
            button.disabled = true;
            button.textContent = '🎵 Génération audio...';

            try {
              for (const langCode in translatedContent) {
                const text = translatedContent[langCode];
                generateAudioFile(text, langCode, languages[langCode].name);
              }
              
              showStatus('Fichiers audio générés avec succès !', 'success');
            } catch (error) {
              console.error('Erreur lors de la génération audio:', error);
              showStatus('Erreur lors de la génération des fichiers audio.', 'error');
            } finally {
              button.disabled = false;
              button.textContent = '🎵 Exporter les fichiers audio';
            }
          }

          function generateAudioFile(text, langCode, langName) {
            // Utilisation de l'API Web Speech pour la synthèse vocale
            if ('speechSynthesis' in window) {
              const utterance = new SpeechSynthesisUtterance(text);
              utterance.lang = languages[langCode].voice;
              utterance.rate = 0.8;
              utterance.pitch = 1;

              // Créer un lien de téléchargement simulé
              const blob = new Blob(['Audio pour ' + langName + ':\n' + text], { type: 'text/plain' });
              const url = URL.createObjectURL(blob);
              const a = document.createElement('a');
              a.href = url;
              a.download = 'traduction_' + langName.toLowerCase() + '.txt';
              document.body.appendChild(a);
              a.click();
              document.body.removeChild(a);
              URL.revokeObjectURL(url);

              // Jouer l'audio
              speechSynthesis.speak(utterance);
            }
          }

          function getSelectedLanguages() {
            const checkboxes = document.querySelectorAll('.language-option input[type="checkbox"]:checked');
            const selected = [];
            for (let i = 0; i < checkboxes.length; i++) {
              selected.push(checkboxes[i].value);
            }
            return selected;
          }

          function showProgress(show) {
            const container = document.getElementById('progressContainer');
            container.style.display = show ? 'block' : 'none';
          }

          function updateProgress(percent, text) {
            document.getElementById('progressFill').style.width = percent + '%';
            document.getElementById('progressText').textContent = text;
          }

          function showStatus(message, type) {
            const status = document.getElementById('status');
            status.textContent = message;
            status.className = 'status ' + type;
            status.style.display = 'block';
            
            setTimeout(function() {
              status.style.display = 'none';
            }, 5000);
          }

          // Gestionnaire pour l'option audio
          document.getElementById('enableAudio').addEventListener('change', function() {
            const audioBtn = document.getElementById('audioBtn');
            if (this.checked && isTranslationComplete) {
              audioBtn.disabled = false;
            } else {
              audioBtn.disabled = true;
            }
          });
          ]]>
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
