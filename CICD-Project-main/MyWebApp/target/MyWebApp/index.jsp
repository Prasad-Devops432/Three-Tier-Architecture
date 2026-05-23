<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nexus Secure - Cloud Security</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; }
        .hero { background: linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.85)), url('https://source.unsplash.com/random/1920x1080/?cyber') center/cover; }
    </style>
</head>
<body class="bg-slate-950 text-slate-100">

    <!-- Navbar -->
    <nav class="fixed top-0 w-full bg-slate-900/95 backdrop-blur-md z-50 border-b border-slate-700">
        <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
            <div class="flex items-center gap-3">
                <i class="fas fa-shield-alt text-3xl text-cyan-400"></i>
                <h1 class="text-2xl font-bold">NEXUS<span class="text-cyan-400">SECURE</span></h1>
            </div>
            <div class="hidden md:flex gap-8">
                <a href="#home" class="hover:text-cyan-400">Home</a>
                <a href="#services" class="hover:text-cyan-400">Services</a>
                <a href="#about" class="hover:text-cyan-400">About</a>
                <a href="#contact" class="hover:text-cyan-400">Contact</a>
            </div>
            <button onclick="getQuote()" class="bg-cyan-500 hover:bg-cyan-600 px-6 py-2.5 rounded-full font-medium">
                Free Consultation
            </button>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero h-screen flex items-center justify-center text-center">
        <div class="max-w-4xl mx-auto px-6">
            <h1 class="text-5xl md:text-7xl font-bold mb-6">
                Protecting Your Cloud.<br>
                <span class="text-cyan-400">Securing Your Future.</span>
            </h1>
            <p class="text-xl mb-10 text-slate-300">
                <%= new SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new Date()) %> 
                — Enterprise FortiGate + AWS Security Solutions
            </p>
            <button onclick="document.getElementById('contact').scrollIntoView({behavior:'smooth'})" 
                    class="bg-cyan-500 text-black px-10 py-4 rounded-full text-lg font-semibold hover:bg-cyan-400 transition">
                Get Started Today
            </button>
        </div>
    </section>

    <!-- Services -->
    <section id="services" class="py-20 bg-slate-900">
        <div class="max-w-7xl mx-auto px-6">
            <h2 class="text-4xl font-bold text-center mb-12">Our Services</h2>
            <div class="grid md:grid-cols-3 gap-8">
                <div class="bg-slate-800 p-8 rounded-2xl">
                    <i class="fas fa-cloud text-5xl text-cyan-400 mb-6"></i>
                    <h3 class="text-2xl font-bold mb-3">FortiGate in AWS</h3>
                    <p class="text-slate-400">Secure VPC design, HA deployment, and next-gen firewall protection.</p>
                </div>
                <div class="bg-slate-800 p-8 rounded-2xl">
                    <i class="fas fa-lock text-5xl text-cyan-400 mb-6"></i>
                    <h3 class="text-2xl font-bold mb-3">Zero Trust Architecture</h3>
                    <p class="text-slate-400">Micro-segmentation and continuous verification.</p>
                </div>
                <div class="bg-slate-800 p-8 rounded-2xl">
                    <i class="fas fa-chart-line text-5xl text-cyan-400 mb-6"></i>
                    <h3 class="text-2xl font-bold mb-3">Compliance Automation</h3>
                    <p class="text-slate-400">ISO 27001, NIST, CIS & HIPAA readiness.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Dynamic Section -->
    <section class="py-16 bg-slate-800">
        <div class="max-w-7xl mx-auto px-6 text-center">
            <h2 class="text-3xl font-bold mb-8">Server Information</h2>
            <div class="grid md:grid-cols-2 gap-8 max-w-2xl mx-auto">
                <div class="bg-slate-900 p-8 rounded-2xl">
                    <p class="text-cyan-400 text-sm">Current Server Time</p>
                    <p class="text-4xl font-mono"><%= new Date() %></p>
                </div>
                <div class="bg-slate-900 p-8 rounded-2xl">
                    <p class="text-cyan-400 text-sm">Your IP Address</p>
                    <p class="text-3xl font-mono"><%= request.getRemoteAddr() %></p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Form -->
    <section id="contact" class="py-20">
        <div class="max-w-2xl mx-auto px-6">
            <h2 class="text-4xl font-bold text-center mb-10">Contact Us</h2>
            <form action="index.jsp" method="post" class="space-y-6">
                <input type="text" name="name" placeholder="Your Name" required
                       class="w-full px-6 py-4 bg-slate-900 border border-slate-700 rounded-xl focus:border-cyan-400 outline-none">
                
                <input type="email" name="email" placeholder="Business Email" required
                       class="w-full px-6 py-4 bg-slate-900 border border-slate-700 rounded-xl focus:border-cyan-400 outline-none">
                
                <textarea name="message" rows="6" placeholder="Describe your project..." required
                          class="w-full px-6 py-4 bg-slate-900 border border-slate-700 rounded-xl focus:border-cyan-400 outline-none"></textarea>
                
                <button type="submit" 
                        class="w-full bg-cyan-500 hover:bg-cyan-600 text-black py-4 rounded-2xl font-bold text-lg">
                    Send Message
                </button>
            </form>
        </div>
    </section>

    <% 
        // Handle form submission
        if ("POST".equals(request.getMethod())) {
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
    %>
                <script>
                    alert("Thank you <%= name %>! Your message has been received. We'll contact you within 24 hours.");
                </script>
    <%
            }
        }
    %>

    <footer class="bg-black py-10 text-center text-slate-500">
        <p>&copy; 2026 Nexus Secure | JSP Demo Website</p>
    </footer>

</body>
</html>
