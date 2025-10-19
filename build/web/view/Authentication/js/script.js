document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('loginForm');
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordInput = document.getElementById('password');
    const card = document.querySelector('.login-card');

    // Hiệu ứng xuất hiện
    card.style.opacity = '0';
    card.style.transform = 'translateY(30px) scale(0.9)';
    setTimeout(() => {
        card.style.transition = 'all 0.8s cubic-bezier(0.4, 0, 0.2, 1)';
        card.style.opacity = '1';
        card.style.transform = 'translateY(0) scale(1)';
    }, 200);

    // Toggle password visibility
    passwordToggle.addEventListener('click', () => {
        const isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        const icon = passwordToggle.querySelector('.toggle-icon');
        icon.classList.toggle('show-password', isPassword);
    });

    // Submit form thật
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const formData = new FormData(form);
        const submitBtn = document.querySelector('.login-btn');
        submitBtn.classList.add('loading');

        try {
            const response = await fetch(form.action, {
                method: 'POST',
                body: formData
            });

            if (response.redirected) {
                window.location.href = response.url;
            } else {
                alert("Invalid username or password!");
            }
        } catch (err) {
            alert("Server connection error!");
            console.error(err);
        } finally {
            submitBtn.classList.remove('loading');
        }
    });
});
