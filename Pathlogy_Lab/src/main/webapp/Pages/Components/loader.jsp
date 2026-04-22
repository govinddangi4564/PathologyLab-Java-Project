<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <style>
        /* Reusable full-screen loader overlay */
        .pl-loader-overlay {
            position: fixed;
            inset: 0;
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.85);
            transition: opacity 0.2s ease;
        }

        .pl-loader-overlay.hidden {
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
        }

        .pl-loader-spinner {
            width: 48px;
            height: 48px;
            border: 5px solid #d1d5db;
            border-top-color: #0ea5e9;
            border-radius: 50%;
            animation: pl-loader-spin 0.8s linear infinite;
        }

        @keyframes pl-loader-spin {
            to {
                transform: rotate(360deg);
            }
        }
    </style>

    <div id="plLoader" class="pl-loader-overlay hidden" aria-live="polite" aria-label="Loading">
        <div class="pl-loader-spinner"></div>
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

        window.addEventListener("load", hideLoader);
    </script>