<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    /* Premium Full-screen Loader Overlay */
    .pl-loader-overlay {
        position: fixed;
        inset: 0;
        z-index: 9999;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        transition: opacity 0.3s ease, visibility 0.3s ease;
    }

    .pl-loader-overlay.hidden {
        opacity: 0;
        visibility: hidden;
        pointer-events: none;
    }

    /* Modern Spinner Rings */
    .pl-loader-spinner {
        position: relative;
        width: 70px;
        height: 70px;
        margin-bottom: 20px;
    }

    .pl-loader-ring {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        border: 4px solid transparent;
        animation: pl-spin 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
    }

    .pl-loader-ring:nth-child(1) {
        border-top-color: #0ea5e9;
        animation-delay: -0.45s;
    }

    .pl-loader-ring:nth-child(2) {
        border-right-color: #3b82f6;
        animation-delay: -0.3s;
        width: 80%;
        height: 80%;
        top: 10%;
        left: 10%;
    }

    .pl-loader-ring:nth-child(3) {
        border-bottom-color: #06b6d4;
        animation-delay: -0.15s;
        width: 60%;
        height: 60%;
        top: 20%;
        left: 20%;
    }

    @keyframes pl-spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Loader Text */
    .pl-loader-text {
        font-family: 'Outfit', 'Manrope', sans-serif;
        font-weight: 600;
        color: #0f172a;
        font-size: 1.1rem;
        letter-spacing: 0.5px;
        background: linear-gradient(90deg, #0ea5e9, #3b82f6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: pl-pulse 1.5s ease-in-out infinite;
    }

    @keyframes pl-pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
    }
</style>

<div id="plLoader" class="pl-loader-overlay hidden" aria-live="polite" aria-label="Loading">
    <div class="pl-loader-spinner">
        <div class="pl-loader-ring"></div>
        <div class="pl-loader-ring"></div>
        <div class="pl-loader-ring"></div>
    </div>
    <div class="pl-loader-text">Processing... Please wait</div>
</div>

<script>
    function showLoader() {
        var loader = document.getElementById("plLoader");
        if (loader) {
            loader.classList.remove("hidden");
        }
    }

    function hideLoader() {
        var loader = document.getElementById("plLoader");
        if (loader) {
            loader.classList.add("hidden");
        }
    }

    // Hide loader when page is fully loaded
    window.addEventListener("load", hideLoader);

    // Also hide it if user navigates back via BFCache
    window.addEventListener("pageshow", function(event) {
        if (event.persisted) {
            hideLoader();
        }
    });

    document.addEventListener("DOMContentLoaded", function () {
        // Auto-hook into all forms
        var forms = document.querySelectorAll("form");
        forms.forEach(function (form) {
            form.addEventListener("submit", function (e) {
                // Check HTML5 validation before showing loader
                if (!form.checkValidity || form.checkValidity()) {
                    showLoader();
                    
                    // Disable submit buttons to prevent double submission
                    setTimeout(function() {
                        var buttons = form.querySelectorAll("button[type='submit'], input[type='submit']");
                        buttons.forEach(function(btn) {
                            btn.disabled = true;
                        });
                    }, 50);
                }
            });
        });

    });
</script>