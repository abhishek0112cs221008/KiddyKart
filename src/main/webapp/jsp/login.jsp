<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CampusKart – Login & Register</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="assets/logo2.png">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One:wght@400&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  --primary-blue: #667eea;
  --primary-purple: #764ba2;
  --accent-coral: #ff7675;
  --accent-teal: #00b894;
  --accent-orange: #fd79a8;
  --success-green: #00b894;
  --warning-orange: #fdcb6e;
  --error-red: #e84393;
  --white: #ffffff;
  --glass-white: rgba(255, 255, 255, 0.25);
  --glass-border: rgba(255, 255, 255, 0.18);
  --text-dark: #2d3436;
  --text-light: rgba(255, 255, 255, 0.85);
  --shadow-light: rgba(255, 255, 255, 0.5);
  --shadow-dark: rgba(0, 0, 0, 0.1);
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-purple) 50%, var(--accent-coral) 100%);
  background-size: 400% 400%;
  background-attachment: fixed;
  animation: gradientFlow 12s ease infinite;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  position: relative;
  overflow-x: hidden;
}

@keyframes gradientFlow {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* Floating Elements */
.floating-elements {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
  overflow: hidden;
}

.floating-shape {
  position: absolute;
  border-radius: 50%;
  opacity: 0.08;
  filter: blur(1px);
}

.shape1 { 
  width: 120px; height: 120px; 
  background: linear-gradient(45deg, var(--accent-teal), var(--accent-coral));
  top: 15%; left: 8%; 
  animation: floatOne 25s infinite ease-in-out;
}

.shape2 { 
  width: 80px; height: 80px; 
  background: linear-gradient(45deg, var(--accent-orange), var(--primary-blue));
  top: 65%; right: 12%; 
  animation: floatTwo 20s infinite ease-in-out reverse;
}

.shape3 { 
  width: 150px; height: 150px; 
  background: linear-gradient(45deg, var(--primary-purple), var(--accent-teal));
  bottom: 25%; left: 15%; 
  animation: floatThree 30s infinite ease-in-out;
}

.shape4 { 
  width: 60px; height: 60px; 
  background: linear-gradient(45deg, var(--accent-coral), var(--accent-orange));
  top: 8%; right: 25%; 
  animation: floatFour 18s infinite ease-in-out reverse;
}

@keyframes floatOne {
  0%, 100% { transform: translate(0, 0) rotate(0deg); }
  25% { transform: translate(30px, -20px) rotate(90deg); }
  50% { transform: translate(-20px, -40px) rotate(180deg); }
  75% { transform: translate(-30px, 20px) rotate(270deg); }
}

@keyframes floatTwo {
  0%, 100% { transform: translate(0, 0) rotate(0deg) scale(1); }
  33% { transform: translate(-25px, 30px) rotate(120deg) scale(1.1); }
  66% { transform: translate(20px, -25px) rotate(240deg) scale(0.9); }
}

@keyframes floatThree {
  0%, 100% { transform: translate(0, 0) rotate(0deg); opacity: 0.08; }
  50% { transform: translate(25px, -30px) rotate(180deg); opacity: 0.12; }
}

@keyframes floatFour {
  0%, 100% { transform: translate(0, 0) rotate(0deg) scale(1); }
  50% { transform: translate(-15px, 25px) rotate(180deg) scale(1.2); }
}

/* Main Container */
.container {
  background: var(--glass-white);
  backdrop-filter: blur(25px);
  -webkit-backdrop-filter: blur(25px);
  border: 1px solid var(--glass-border);
  border-radius: 24px;
  padding: 48px 36px 36px;
  width: 95%;
  max-width: 440px;
  min-width: 320px;
  text-align: center;
  position: relative;
  z-index: 10;
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.12),
    0 2px 16px rgba(0, 0, 0, 0.08),
    inset 0 1px 0 var(--shadow-light);
  animation: containerEntrance 0.8s cubic-bezier(0.4, 0, 0.2, 1);
  transition: all 0.3s ease;
}

@keyframes containerEntrance {
  0% {
    opacity: 0;
    transform: translateY(40px) scale(0.95);
    filter: blur(10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0) scale(1);
    filter: blur(0px);
  }
}

.container:hover {
  box-shadow: 
    0 12px 48px rgba(0, 0, 0, 0.15),
    0 4px 24px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 var(--shadow-light);
}

/* Logo Section */
.logo-section {
  margin-bottom: 40px;
  position: relative;
}

.logo-container {
  width: 90px;
  height: 90px;
  margin: 0 auto 20px;
  position: relative;
  animation: logoFloat 6s ease-in-out infinite;
  transition: all 0.3s ease;
}

@keyframes logoFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-8px); }
}

.logo-container:hover {
  transform: scale(1.05) translateY(-5px);
}

.logo-container img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
  /* box-shadow: 
    0 8px 24px rgba(0, 0, 0, 0.15),
    0 2px 8px rgba(0, 0, 0, 0.1); */
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* .logo-container:hover img {
  box-shadow: 
    0 12px 32px rgba(0, 0, 0, 0.2),
    0 4px 16px rgba(0, 0, 0, 0.15);
} */

.logo-title {
  font-family: 'Fredoka One', cursive;
  font-size: 2.4em;
  font-weight: 400;
  background: linear-gradient(135deg, var(--primary-blue), var(--accent-coral), var(--accent-teal));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 8px;
  line-height: 1.2;
  animation: titleGlow 3s ease-in-out infinite alternate;
}

@keyframes titleGlow {
  0% { filter: brightness(1); }
  100% { filter: brightness(1.1); }
}

.logo-subtitle {
  color: var(--text-light);
  font-size: 1rem;
  font-weight: 500;
  opacity: 0.9;
}

/* Tab Navigation */
.tabs {
  margin-bottom: 32px;
  display: flex;
  justify-content: center;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 50px;
  padding: 4px;
  position: relative;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.tab-slider {
  position: absolute;
  top: 4px;
  left: 4px;
  width: calc(50% - 4px);
  height: calc(100% - 8px);
  background: linear-gradient(135deg, var(--primary-blue), var(--accent-coral));
  border-radius: 46px;
  transition: transform 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
  box-shadow: 
    0 4px 16px rgba(102, 126, 234, 0.3),
    0 2px 8px rgba(102, 126, 234, 0.2);
}

.tab-btn {
  background: transparent;
  border: none;
  font-size: 1rem;
  font-weight: 600;
  color: var(--text-light);
  padding: 14px 0;
  cursor: pointer;
  flex: 1;
  position: relative;
  z-index: 2;
  transition: all 0.3s ease;
  border-radius: 46px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.tab-btn.active {
  color: var(--white);
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.tab-btn:hover:not(.active) {
  color: var(--white);
  transform: translateY(-1px);
}

.tab-btn i {
  font-size: 1.1em;
}

/* Form Blocks */
.form-block {
  display: none !important;
  animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.form-block.active { 
  display: block !important; 
}

@keyframes fadeInUp {
  0% {
    opacity: 0;
    transform: translateY(30px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Input Groups */
.input-group {
  margin-bottom: 24px;
  position: relative;
}

.input-group input {
  width: 100%;
  padding: 18px 55px 18px 22px;
  border: 2px solid rgba(255, 255, 255, 0.25);
  border-radius: 16px;
  outline: none;
  font-size: 1rem;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  color: var(--text-dark);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  font-family: inherit;
}

.input-group input::placeholder {
  color: rgba(45, 52, 54, 0.6);
  font-weight: 400;
}

.input-group input:focus {
  border-color: var(--primary-blue);
  background: var(--white);
  transform: translateY(-2px);
  box-shadow: 
    0 8px 25px rgba(102, 126, 234, 0.25),
    0 4px 12px rgba(102, 126, 234, 0.15);
}

.input-group input:valid:not(:placeholder-shown) {
  border-color: var(--success-green);
}

.input-group .icon {
  position: absolute;
  right: 22px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 1.25em;
  color: var(--primary-blue);
  pointer-events: none;
  transition: all 0.3s ease;
  opacity: 0.7;
}

.input-group input:focus + .icon {
  color: var(--accent-coral);
  transform: translateY(-50%) scale(1.1);
  opacity: 1;
}

.input-group input:valid:not(:placeholder-shown) + .icon {
  color: var(--success-green);
}

/* Submit Buttons */
.submit-btn {
  background: linear-gradient(135deg, var(--primary-blue) 0%, var(--accent-coral) 100%);
  background-size: 200% 200%;
  color: var(--white);
  padding: 18px 0;
  font-size: 1.1em;
  font-weight: 700;
  border: none;
  border-radius: 16px;
  width: 100%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  box-shadow: 
    0 8px 25px rgba(102, 126, 234, 0.35),
    0 4px 12px rgba(102, 126, 234, 0.25);
  font-family: inherit;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.submit-btn:hover {
  background-position: 100% 0;
  transform: translateY(-3px);
  box-shadow: 
    0 12px 35px rgba(102, 126, 234, 0.4),
    0 6px 18px rgba(102, 126, 234, 0.3);
}

.submit-btn:active {
  transform: translateY(-1px);
  transition: all 0.1s ease;
}

.submit-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
  box-shadow: 
    0 4px 15px rgba(102, 126, 234, 0.2),
    0 2px 8px rgba(102, 126, 234, 0.15);
}

.submit-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.6s ease;
}

.submit-btn:hover::before {
  left: 100%;
}

.submit-btn i {
  font-size: 1.2em;
}

/* Loading Spinner */
.loading-spinner {
  display: inline-block;
  width: 18px;
  height: 18px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: var(--white);
  animation: spin 1s linear infinite;
  margin-left: 8px;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* Back Link */
.back-link {
  color: var(--text-light);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  margin-top: 28px;
  font-size: 0.95rem;
  font-weight: 500;
  padding: 12px 24px;
  border-radius: 50px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.15);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  gap: 8px;
}

.back-link:hover {
  color: var(--white);
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  border-color: rgba(255, 255, 255, 0.25);
}

.back-link i {
  font-size: 1.1em;
  transition: transform 0.3s ease;
}

.back-link:hover i {
  transform: translateX(-3px);
}

/* Messages */
.message {
  padding: 16px 24px;
  border-radius: 12px;
  margin-bottom: 24px;
  font-weight: 500;
  backdrop-filter: blur(10px);
  animation: messageSlide 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid;
}

@keyframes messageSlide {
  0% {
    opacity: 0;
    transform: translateY(-10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

.message.success {
  background: rgba(0, 184, 148, 0.15);
  color: #00b894;
  border-color: rgba(0, 184, 148, 0.3);
}

.message.error {
  background: rgba(232, 67, 147, 0.15);
  color: #e84393;
  border-color: rgba(232, 67, 147, 0.3);
}

/* Responsive Design */
@media (max-width: 768px) {
  .container {
    padding: 40px 28px 28px;
    margin: 16px;
    border-radius: 20px;
    max-width: 400px;
  }
  
  .logo-title {
    font-size: 2.1em;
  }
  
  .input-group input {
    padding: 16px 50px 16px 20px;
    font-size: 16px; /* Prevents zoom on iOS */
  }
  
  .submit-btn {
    padding: 16px 0;
    font-size: 1rem;
  }
  
  .tab-btn {
    font-size: 0.95rem;
    padding: 12px 0;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 36px 24px 24px;
    margin: 12px;
  }
  
  .logo-container {
    width: 80px;
    height: 80px;
  }
  
  .logo-title {
    font-size: 1.9em;
  }
  
  .tabs {
    margin-bottom: 28px;
  }
  
  .input-group {
    margin-bottom: 20px;
  }
  
  .input-group input {
    padding: 15px 45px 15px 18px;
  }
  
  .input-group .icon {
    right: 18px;
    font-size: 1.15em;
  }
  
  .submit-btn {
    padding: 15px 0;
    font-size: 0.95rem;
  }
  
  .back-link {
    font-size: 0.9rem;
    padding: 10px 20px;
  }
}

@media (max-width: 360px) {
  .container {
    padding: 32px 20px 20px;
    margin: 8px;
  }
  
  .logo-title {
    font-size: 1.7em;
  }
  
  .tab-btn {
    font-size: 0.9rem;
    gap: 6px;
  }
  
  .tab-btn i {
    font-size: 1em;
  }
}

/* High DPI Displays */
@media (-webkit-min-device-pixel-ratio: 2), (min-resolution: 192dpi) {
  .container {
    backdrop-filter: blur(30px);
    -webkit-backdrop-filter: blur(30px);
  }
}

/* Reduced Motion */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}

/* Focus Visible */
.tab-btn:focus-visible,
.submit-btn:focus-visible,
.input-group input:focus-visible,
.back-link:focus-visible {
  outline: 2px solid var(--accent-coral);
  outline-offset: 2px;
}

/* Print Styles */
@media print {
  .floating-elements {
    display: none;
  }
  
  .container {
    background: white;
    box-shadow: none;
    border: 1px solid #ccc;
  }
  
  .logo-title {
    -webkit-text-fill-color: initial;
    color: #333;
  }
}
</style>
</head>
<body>
  <!-- Floating Background Elements -->
  <div class="floating-elements">
    <div class="floating-shape shape1"></div>
    <div class="floating-shape shape2"></div>
    <div class="floating-shape shape3"></div>
    <div class="floating-shape shape4"></div>
  </div>

  <div class="container">
    <div class="logo-section">
      <div class="logo-container">
        <img src="../assets/logo2.png" alt="KiddyKart Logo" draggable="false">
      </div>
      <!-- <h1 class="logo-title">KiddyKart</h1> -->
      <p class="logo-subtitle">Where Fun Meets Shopping</p>
    </div>
    
    <div class="tabs">
      <div class="tab-slider"></div>
      <button type="button" class="tab-btn active" onclick="showTab('login')" data-tab="login" aria-label="Switch to Login">
        <i class="bi bi-box-arrow-in-right" aria-hidden="true"></i>
        <span>Login</span>
      </button>
      <!-- <button type="button" class="tab-btn" onclick="showTab('register')" data-tab="register" aria-label="Switch to Register">
        <i class="bi bi-person-plus" aria-hidden="true"></i>
        <span>Register</span>
      </button> -->
      
      <button type="button" class="tab-btn">
        <i class="bi bi-person-plus" aria-hidden="true"></i>
        <span><a href="register.jsp">Register</a></span>
      </button>
    </div>
    
    <!-- Login Form -->
    <div id="login" class="form-block active" style="display: block;">
      <form method="post" action="../LoginServlet" autocomplete="on" novalidate>
        <div class="input-group">
          <input 
            type="email" 
            name="email" 
            placeholder="Enter your email address" 
            required 
            autocomplete="email"
            aria-label="Email Address"
          >
          <span class="icon" aria-hidden="true"><i class="bi bi-envelope"></i></span>
        </div>
        <div class="input-group">
          <input 
            type="password" 
            name="password" 
            placeholder="Enter your password" 
            required 
            autocomplete="current-password"
            aria-label="Password"
          >
          <span class="icon" aria-hidden="true"><i class="bi bi-shield-lock"></i></span>
        </div>
        <button type="submit" class="submit-btn" aria-label="Sign in to your account">
          <i class="bi bi-rocket-takeoff" aria-hidden="true"></i>
          <span>Sign In</span>
        </button>
      </form>
    </div>
    
    <!-- Register Form -->
    <div id="register" class="form-block" style="display: none;">
      <form method="post" action="../RegisterServlet" autocomplete="on" novalidate>
        <div class="input-group">
          <input 
            type="text" 
            name="name" 
            placeholder="Enter your full name" 
            required 
            autocomplete="name"
            aria-label="Full Name"
          >
          <span class="icon" aria-hidden="true"><i class="bi bi-person"></i></span>
        </div>
        <div class="input-group">
          <input 
            type="email" 
            name="email" 
            placeholder="Enter your email address" 
            required 
            autocomplete="email"
            aria-label="Email Address"
          >
          <span class="icon" aria-hidden="true"><i class="bi bi-envelope"></i></span>
        </div>
        <div class="input-group">
          <input 
            type="password" 
            name="password" 
            placeholder="Create a secure password" 
            required 
            autocomplete="new-password"
            aria-label="Password"
            minlength="8"
          >
          <span class="icon" aria-hidden="true"><i class="bi bi-shield-lock"></i></span>
        </div>
        <button type="submit" class="submit-btn" aria-label="Create your account">
          <i class="bi bi-star-fill" aria-hidden="true"></i>
          <span>Create Account</span>
        </button>
      </form>
    </div>
    
    <a href="../index.html" class="back-link" aria-label="Go back to homepage">
      <i class="bi bi-arrow-left" aria-hidden="true"></i>
      <span>Back to Home</span>
    </a>
  </div>

  <script>
    'use strict';

    // DOM Elements
    const tabBtns = document.querySelectorAll('.tab-btn');
    const formBlocks = document.querySelectorAll('.form-block');
    const tabSlider = document.querySelector('.tab-slider');
    const submitBtns = document.querySelectorAll('.submit-btn');
    const inputs = document.querySelectorAll('input');

    // Tab switching functionality
    function showTab(tabName) {
     
      if (!tabName || !['login', 'register'].includes(tabName)) {
        return;
      }

      try {
        // Force show/hide the correct forms
        const allFormBlocks = document.querySelectorAll('.form-block');
        const targetForm = document.getElementById(tabName);
        
        // Hide all forms first
        allFormBlocks.forEach(form => {
          form.style.display = 'none';
          form.classList.remove('active');
        });
        
        // Show target form
        if (targetForm) {
          targetForm.style.display = 'block';
          targetForm.classList.add('active');
        }

        // Remove active classes from all tabs and forms
        const allTabBtns = document.querySelectorAll('.tab-btn');
        const allFormBlocks = document.querySelectorAll('.form-block');
        
        allTabBtns.forEach(btn => {
          btn.classList.remove('active');
          btn.setAttribute('aria-selected', 'false');
        });
        
        allFormBlocks.forEach(form => {
          form.classList.remove('active');
        });
        
        // Find and activate the correct tab and form
        const targetForm = document.getElementById(tabName);
        const targetBtn = tabName === 'login' ? 
          document.querySelector('.tab-btn:first-child') : 
          document.querySelector('.tab-btn:last-child');
        
        if (targetBtn && targetForm) {
          // Activate the button and form
          targetBtn.classList.add('active');
          targetBtn.setAttribute('aria-selected', 'true');
          targetForm.classList.add('active');
          
          console.log('Activated:', tabName, targetBtn, targetForm); // Debug log
          
          // Move the slider
          const btnIndex = Array.from(allTabBtns).indexOf(targetBtn);
          if (tabSlider) {
            tabSlider.style.transform = `translateX(${btnIndex * 100}%)`;
          }
          
          // Focus first input in active form (with delay for animation)
          setTimeout(() => {
            const firstInput = targetForm.querySelector('input');
            if (firstInput) {
              firstInput.focus();
            }
          }, 100);
        } else {
          console.error('Could not find target button or form for:', tabName);
        }
      } catch (error) {
        console.error('Error in showTab:', error);
      }
    }

    // Form submission handling
    function handleFormSubmit(event) {
      const form = event.target;
      const submitBtn = form.querySelector('.submit-btn');
      const btnText = submitBtn.querySelector('span');
      const btnIcon = submitBtn.querySelector('i');
      
      if (!form.checkValidity()) {
        event.preventDefault();
        showValidationErrors(form);
        return;
      }

      // Show loading state
      const originalText = btnText.textContent;
      const originalIcon = btnIcon.className;
      
      btnText.textContent = 'Please wait...';
      btnIcon.className = '';
      submitBtn.disabled = true;
      
      // Add loading spinner
      const spinner = document.createElement('div');
      spinner.className = 'loading-spinner';
      submitBtn.appendChild(spinner);

      // Reset after timeout (for demo purposes)
      setTimeout(() => {
        btnText.textContent = originalText;
        btnIcon.className = originalIcon;
        submitBtn.disabled = false;
        if (spinner.parentNode) {
          spinner.remove();
        }
      }, 3000);
    }

    // Validation error display
    function showValidationErrors(form) {
      const inputs = form.querySelectorAll('input');
      
      inputs.forEach(input => {
        if (!input.checkValidity()) {
          input.style.borderColor = 'var(--error-red)';
          input.style.boxShadow = '0 0 0 3px rgba(232, 67, 147, 0.1)';
          
          // Reset error styling after user starts typing
          const resetError = () => {
            input.style.borderColor = '';
            input.style.boxShadow = '';
            input.removeEventListener('input', resetError);
          };
          input.addEventListener('input', resetError);
        }
      });
    }

    // Input validation feedback
    function setupInputValidation() {
      inputs.forEach(input => {
        input.addEventListener('blur', function() {
          if (this.value && !this.checkValidity()) {
            this.style.borderColor = 'var(--error-red)';
          } else if (this.value && this.checkValidity()) {
            this.style.borderColor = 'var(--success-green)';
          }
        });

        input.addEventListener('input', function() {
          if (this.style.borderColor === 'rgb(232, 67, 147)') { // error-red
            this.style.borderColor = '';
            this.style.boxShadow = '';
          }
        });
      });
    }

    // Enhanced keyboard navigation
    function setupKeyboardNavigation() {
      document.addEventListener('keydown', function(e) {
        // Tab navigation with arrow keys
        if (e.key === 'ArrowLeft' || e.key === 'ArrowRight') {
          const activeTab = document.querySelector('.tab-btn.active');
          if (activeTab && document.activeElement === activeTab) {
            e.preventDefault();
            const currentIndex = Array.from(tabBtns).indexOf(activeTab);
            const nextIndex = e.key === 'ArrowRight' ? 
              (currentIndex + 1) % tabBtns.length : 
              (currentIndex - 1 + tabBtns.length) % tabBtns.length;
            
            const targetTab = tabBtns[nextIndex];
            const tabName = targetTab.onclick.toString().match(/'([^']+)'/)[1];
            showTab(tabName);
            targetTab.focus();
          }
        }

        // Enter key on tabs
        if (e.key === 'Enter' && document.activeElement.classList.contains('tab-btn')) {
          document.activeElement.click();
        }

        // Escape key to focus first input
        if (e.key === 'Escape') {
          const activeForm = document.querySelector('.form-block.active');
          const firstInput = activeForm?.querySelector('input');
          if (firstInput) {
            firstInput.focus();
          }
        }
      });
    }

    // Smooth container hover effect
    function setupContainerInteraction() {
      const container = document.querySelector('.container');
      let isHovering = false;

      container.addEventListener('mouseenter', () => {
        isHovering = true;
      });

      container.addEventListener('mouseleave', () => {
        isHovering = false;
        container.style.transform = '';
      });

      container.addEventListener('mousemove', (e) => {
        if (!isHovering) return;

        const rect = container.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        
        const rotateX = (y - centerY) / 30;
        const rotateY = (centerX - x) / 30;
        
        container.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
      });
    }

    // Password strength indicator
    function setupPasswordStrength() {
      const passwordInputs = document.querySelectorAll('input[type="password"]');
      
      passwordInputs.forEach(input => {
        if (input.name === 'password' && input.closest('#register')) {
          input.addEventListener('input', function() {
            const strength = calculatePasswordStrength(this.value);
            updatePasswordStrengthUI(this, strength);
          });
        }
      });
    }

    function calculatePasswordStrength(password) {
      let score = 0;
      
      if (password.length >= 8) score += 1;
      if (password.length >= 12) score += 1;
      if (/[a-z]/.test(password)) score += 1;
      if (/[A-Z]/.test(password)) score += 1;
      if (/[0-9]/.test(password)) score += 1;
      if (/[^A-Za-z0-9]/.test(password)) score += 1;
      
      return Math.min(score, 4);
    }

    function updatePasswordStrengthUI(input, strength) {
      const colors = ['#e84393', '#fd79a8', '#fdcb6e', '#00b894'];
      const color = colors[strength - 1] || '#e84393';
      
      if (strength > 0) {
        input.style.borderColor = color;
        input.style.boxShadow = `0 0 0 3px ${color}20`;
      }
    }

    // Email validation enhancement
    function setupEmailValidation() {
      const emailInputs = document.querySelectorAll('input[type="email"]');
      
      emailInputs.forEach(input => {
        input.addEventListener('blur', function() {
          if (this.value && !isValidEmail(this.value)) {
            this.style.borderColor = 'var(--error-red)';
            this.setCustomValidity('Please enter a valid email address');
          } else {
            this.setCustomValidity('');
          }
        });
      });
    }

    function isValidEmail(email) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return emailRegex.test(email);
    }

    // Accessibility improvements
    function setupAccessibility() {
      // Announce tab changes to screen readers
      const tabButtons = document.querySelectorAll('.tab-btn');
      tabButtons.forEach(button => {
        button.setAttribute('role', 'tab');
        button.setAttribute('aria-selected', button.classList.contains('active'));
      });

      // Set up tab panel attributes
      const tabPanels = document.querySelectorAll('.form-block');
      tabPanels.forEach((panel, index) => {
        panel.setAttribute('role', 'tabpanel');
        panel.setAttribute('aria-labelledby', `tab-${index}`);
      });

      // Add skip link for keyboard users
      const skipLink = document.createElement('a');
      skipLink.href = '#login';
      skipLink.textContent = 'Skip to main content';
      skipLink.className = 'skip-link';
      skipLink.style.cssText = `
        position: absolute;
        top: -40px;
        left: 6px;
        background: var(--primary-blue);
        color: white;
        padding: 8px;
        text-decoration: none;
        border-radius: 4px;
        z-index: 1000;
        transition: top 0.3s;
      `;
      skipLink.addEventListener('focus', () => {
        skipLink.style.top = '6px';
      });
      skipLink.addEventListener('blur', () => {
        skipLink.style.top = '-40px';
      });
      document.body.prepend(skipLink);
    }

    // Performance optimization
    function optimizePerformance() {
      // Debounce input validation
      const debounce = (func, wait) => {
        let timeout;
        return function executedFunction(...args) {
          const later = () => {
            clearTimeout(timeout);
            func(...args);
          };
          clearTimeout(timeout);
          timeout = setTimeout(later, wait);
        };
      };

      // Apply debouncing to input validation
      inputs.forEach(input => {
        const debouncedValidation = debounce(() => {
          if (input.value) {
            input.checkValidity();
          }
        }, 300);

        input.addEventListener('input', debouncedValidation);
      });

      // Optimize animations for better performance
      if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
        document.documentElement.style.setProperty('--animation-duration', '0.01ms');
      }
    }

    // Error handling
    function setupErrorHandling() {
      window.addEventListener('error', function(e) {
        console.error('An error occurred:', e.error);
        // You could send this to your logging service
      });

      // Handle form submission errors
      document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
          try {
            handleFormSubmit(e);
          } catch (error) {
            console.error('Form submission error:', error);
            e.preventDefault();
          }
        });
      });
    }

    // Initialize everything when DOM is ready
    function init() {
      try {
        setupInputValidation();
        setupKeyboardNavigation();
        setupContainerInteraction();
        setupPasswordStrength();
        setupEmailValidation();
        setupAccessibility();
        optimizePerformance();
        setupErrorHandling();

        // Ensure both forms exist and set initial state properly
        const loginForm = document.getElementById('login');
        const registerForm = document.getElementById('register');
        
        if (loginForm && registerForm) {
          // Force initial state
          loginForm.style.display = 'block';
          loginForm.classList.add('active');
          registerForm.style.display = 'none';
          registerForm.classList.remove('active');
          
          // Set first tab as active
          const firstTab = document.querySelector('.tab-btn:first-child');
          const secondTab = document.querySelector('.tab-btn:last-child');
          if (firstTab && secondTab) {
            firstTab.classList.add('active');
            secondTab.classList.remove('active');
          }
          
          console.log('Initial state set - Login form visible');
        }

        // Add click event listeners to tab buttons as backup
        document.querySelectorAll('.tab-btn').forEach(btn => {
          btn.addEventListener('click', function(e) {
            e.preventDefault();
            const tabName = this.getAttribute('data-tab') || 
                           (this.textContent.trim().toLowerCase().includes('login') ? 'login' : 'register');
            console.log('Tab button clicked:', tabName);
            showTab(tabName);
          });
        });

        // Ensure login tab is active by default - REMOVED this line since we set it above
        // showTab('login');

        // Set initial focus
        setTimeout(() => {
          const firstInput = document.querySelector('.form-block.active input');
          if (firstInput) {
            firstInput.focus();
          }
        }, 100);

        console.log('KiddyKart login page initialized successfully');
      } catch (error) {
        console.error('Initialization error:', error);
      }
    }

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', init);
    } else {
      init();
    }

    // Expose showTab function globally for onclick handlers
    window.showTab = showTab;

  </script>
</body>
</html>
