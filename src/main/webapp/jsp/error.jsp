<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Oopsie! - CampusKart</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="assets/logo2.png">
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One:wght@400&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Nunito', 'Comic Sans MS', cursive, sans-serif;
  background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
  background-size: 400% 400%;
  animation: gradientWave 8s ease infinite;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

@keyframes gradientWave {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* Floating warning symbols */
.floating-warnings {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.warning-symbol {
  position: absolute;
  font-size: 2rem;
  opacity: 0.3;
  animation: floatWarning 12s infinite ease-in-out;
}

.warning-1 { top: 10%; left: 15%; animation-delay: 0s; }
.warning-2 { top: 20%; right: 20%; animation-delay: 2s; }
.warning-3 { bottom: 30%; left: 10%; animation-delay: 4s; }
.warning-4 { top: 60%; right: 10%; animation-delay: 6s; }
.warning-5 { bottom: 20%; right: 30%; animation-delay: 8s; }

@keyframes floatWarning {
  0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.3; }
  25% { transform: translateY(-20px) rotate(90deg); opacity: 0.5; }
  50% { transform: translateY(-30px) rotate(180deg); opacity: 0.2; }
  75% { transform: translateY(-15px) rotate(270deg); opacity: 0.4; }
}

.error-container {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-radius: 30px;
  padding: 50px 40px;
  text-align: center;
  box-shadow: 
    0 20px 60px rgba(255, 107, 107, 0.3),
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  border: 2px solid rgba(255, 182, 193, 0.5);
  max-width: 500px;
  width: 90%;
  position: relative;
  z-index: 10;
  animation: bounceIn 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

@keyframes bounceIn {
  0% {
    opacity: 0;
    transform: scale(0.3) rotate(-10deg);
  }
  50% {
    opacity: 1;
    transform: scale(1.05) rotate(2deg);
  }
  70% {
    transform: scale(0.9) rotate(-1deg);
  }
  100% {
    opacity: 1;
    transform: scale(1) rotate(0deg);
  }
}

.error-icon {
  font-size: 4rem;
  margin-bottom: 20px;
  animation: shake 2s infinite;
  display: inline-block;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  10%, 30%, 50%, 70%, 90% { transform: translateX(-8px) rotate(-5deg); }
  20%, 40%, 60%, 80% { transform: translateX(8px) rotate(5deg); }
}

.error-title {
  font-family: 'Fredoka One', cursive;
  font-size: 2.5rem;
  color: #e74c3c;
  margin-bottom: 15px;
  text-shadow: 2px 2px 4px rgba(231, 76, 60, 0.3);
  animation: titlePulse 2s ease-in-out infinite alternate;
}

@keyframes titlePulse {
  0% { transform: scale(1); }
  100% { transform: scale(1.02); }
}

.error-message {
  font-size: 1.2rem;
  color: #c0392b;
  margin-bottom: 10px;
  font-weight: 600;
  line-height: 1.4;
}

.funny-message {
  font-size: 1rem;
  color: #8e44ad;
  margin-bottom: 30px;
  font-style: italic;
  animation: wiggle 3s ease-in-out infinite;
}

@keyframes wiggle {
  0%, 100% { transform: rotate(0deg); }
  25% { transform: rotate(1deg); }
  75% { transform: rotate(-1deg); }
}

.warning-box {
  background: linear-gradient(45deg, #ff6b6b, #feca57);
  border-radius: 20px;
  padding: 20px;
  margin: 25px 0;
  border: 3px dashed #fff;
  animation: warningPulse 2s ease-in-out infinite alternate;
  position: relative;
  overflow: hidden;
}

@keyframes warningPulse {
  0% { box-shadow: 0 0 10px rgba(255, 107, 107, 0.5); }
  100% { box-shadow: 0 0 30px rgba(255, 107, 107, 0.8); }
}

.warning-box::before {
  content: '';
  position: absolute;
  top: -2px;
  left: -100%;
  width: 100%;
  height: calc(100% + 4px);
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  animation: warningShine 3s infinite;
}

@keyframes warningShine {
  0% { left: -100%; }
  100% { left: 100%; }
}

.warning-text {
  color: white;
  font-weight: 700;
  font-size: 1.1rem;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 2;
}

.warning-text .warning-emoji {
  font-size: 1.4em;
  animation: spin 2s linear infinite;
  display: inline-block;
  margin: 0 5px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.back-button {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
  color: white;
  text-decoration: none;
  padding: 15px 30px;
  border-radius: 50px;
  font-size: 1.1rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  box-shadow: 
    0 8px 25px rgba(255, 107, 107, 0.4),
    0 4px 12px rgba(0, 0, 0, 0.1);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.back-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s;
}

.back-button:hover::before {
  left: 100%;
}

.back-button:hover {
  transform: translateY(-3px) scale(1.05);
  box-shadow: 
    0 12px 35px rgba(255, 107, 107, 0.5),
    0 6px 18px rgba(0, 0, 0, 0.15);
}

.back-button:active {
  transform: translateY(-1px) scale(1.02);
}

.back-icon {
  font-size: 1.3rem;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 100% { transform: translateX(0); }
  50% { transform: translateX(-5px); }
}

/* Fun facts section */
.fun-facts {
  margin-top: 20px;
  padding: 15px;
  background: rgba(142, 68, 173, 0.1);
  border-radius: 15px;
  border: 2px dotted #8e44ad;
}

.fun-facts h4 {
  color: #8e44ad;
  font-size: 1rem;
  margin-bottom: 8px;
  font-weight: 600;
}

.fun-facts p {
  color: #7d3c98;
  font-size: 0.9rem;
  font-style: italic;
}

/* Responsive Design */
@media (max-width: 600px) {
  .error-container {
    padding: 40px 25px;
    margin: 20px;
    border-radius: 25px;
  }
  
  .error-title {
    font-size: 2rem;
  }
  
  .error-message {
    font-size: 1.1rem;
  }
  
  .back-button {
    padding: 12px 25px;
    font-size: 1rem;
  }
  
  .warning-symbol {
    font-size: 1.5rem;
  }
}

@media (max-width: 400px) {
  .error-container {
    padding: 30px 20px;
  }
  
  .error-title {
    font-size: 1.8rem;
  }
  
  .error-icon {
    font-size: 3rem;
  }
  
  .back-button {
    padding: 10px 20px;
    font-size: 0.95rem;
  }
}

/* Add some particles for extra fun */
.particles {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 2;
}

.particle {
  position: absolute;
  width: 6px;
  height: 6px;
  background: #ff6b6b;
  border-radius: 50%;
  animation: particleFall 5s infinite linear;
  opacity: 0.7;
}

@keyframes particleFall {
  0% {
    opacity: 0;
    transform: translateY(-100vh) rotate(0deg);
  }
  10% {
    opacity: 0.7;
  }
  90% {
    opacity: 0.7;
  }
  100% {
    opacity: 0;
    transform: translateY(100vh) rotate(360deg);
  }
}
</style>
</head>
<body>
  <!-- Floating Warning Symbols -->
  <div class="floating-warnings">
    <div class="warning-symbol warning-1">⚠️</div>
    <div class="warning-symbol warning-2">🚫</div>
    <div class="warning-symbol warning-3">❌</div>
    <div class="warning-symbol warning-4">⛔</div>
    <div class="warning-symbol warning-5">🚨</div>
  </div>

  <!-- Particle System -->
  <div class="particles" id="particles"></div>

  <div class="error-container">
    <div class="error-icon">🤦‍♂️</div>
    
    <h1 class="error-title">Oopsie Daisy!</h1>
    
    <p class="error-message">
      🎯 Your email and password are having a disagreement!
    </p>
    
    <p class="funny-message">
      "Maybe they need couples therapy? 🤔💕"
    </p>

    <div class="warning-box">
      <p class="warning-text">
        <span class="warning-emoji">⚠️</span>
        <strong>WARNING:</strong> Your login credentials are playing hide and seek!
        <span class="warning-emoji">🙈</span>
      </p>
    </div>

    <div class="fun-facts">
      <h4>🎪 Fun Fact:</h4>
      <p>Did you know? 73% of wrong passwords are caused by the Caps Lock key having a secret agenda! 🤖</p>
    </div>

    <a href="login.jsp" class="back-button">
      <span class="back-icon">🔐</span>
      <span>Try Again, Champion!</span>
    </a>
  </div>

  <script>
    // Create falling particles
    function createParticle() {
      const particle = document.createElement('div');
      particle.classList.add('particle');
      
      // Random position and properties
      particle.style.left = Math.random() * 100 + '%';
      particle.style.animationDelay = Math.random() * 5 + 's';
      particle.style.animationDuration = (Math.random() * 3 + 3) + 's';
      
      // Random colors
      const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#a8e6cf', '#ff8b94'];
      particle.style.background = colors[Math.floor(Math.random() * colors.length)];
      
      document.getElementById('particles').appendChild(particle);
      
      // Remove particle after animation
      setTimeout(() => {
        if (particle.parentNode) {
          particle.parentNode.removeChild(particle);
        }
      }, 8000);
    }

    // Create particles continuously
    setInterval(createParticle, 300);

    // Add some interactive fun
    document.querySelector('.error-container').addEventListener('click', function(e) {
      if (e.target.classList.contains('error-icon')) {
        // Change the emoji when clicked
        const emojis = ['🤦‍♂️', '😅', '🤷‍♂️', '😊', '🙃', '😜'];
        const randomEmoji = emojis[Math.floor(Math.random() * emojis.length)];
        e.target.textContent = randomEmoji;
        
        setTimeout(() => {
          e.target.textContent = '🤦‍♂️';
        }, 2000);
      }
    });

    // Easter egg: Konami code
    let konamiCode = [];
    const konamiSequence = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
    
    document.addEventListener('keydown', (e) => {
      konamiCode.push(e.keyCode);
      if (konamiCode.length > konamiSequence.length) {
        konamiCode.shift();
      }
      
      if (JSON.stringify(konamiCode) === JSON.stringify(konamiSequence)) {
        // Secret rainbow mode
        document.body.style.filter = 'hue-rotate(0deg)';
        let hue = 0;
        const rainbowInterval = setInterval(() => {
          hue += 10;
          document.body.style.filter = `hue-rotate(${hue}deg)`;
          if (hue >= 360) {
            clearInterval(rainbowInterval);
            document.body.style.filter = '';
          }
        }, 100);
      }
    });

    // Add some sound effects (if you want to add audio)
    function playErrorSound() {
      // You could add audio here if needed
      console.log('🎵 *Sad trombone sound* 🎺');
    }

    // Trigger error sound on page load
    setTimeout(playErrorSound, 500);
  </script>
</body>
</html>