<%-- Fichier : src/main/webapp/WEB-INF/views/clients.jsp --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Clients</title>
    <style>
        /* ------- GENERAL ------- */
        :root {
            --primary-color: #3b82f6; /* blue-500 */
            --primary-hover: #2563eb; /* blue-600 */
            --danger-color: #ef4444; /* red-500 */
            --danger-hover: #dc2626; /* red-600 */
            --success-color: #22c55e; /* green-500 */
            --success-hover: #16a34a; /* green-600 */
            --gray-color: #e5e7eb; /* gray-200 */
            --text-color: #374151; /* gray-700 */
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: #f9fafb;
            color: var(--text-color);
            margin: 0;
            transition: background-color 0.3s;
        }
        body.form-open, body.modal-open {
            overflow: hidden;
        }
        .container {
            max-width: 1024px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        /* ------- HEADER & TABLE ------- */
        header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        header h1 { font-size: 2.25rem; font-weight: 700; color: #1f2937; }
        .table-container { background-color: white; border-radius: 0.5rem; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 1rem; text-align: left; }
        thead { background-color: var(--gray-color); }
        tbody tr:nth-child(even) { background-color: #f9fafb; }
        tbody tr:hover { background-color: #f3f4f6; }

        /* ------- BOUTONS ------- */
        .btn {
            font-weight: 600; padding: 0.5rem 1rem; border-radius: 0.5rem; border: none; cursor: pointer; transition: background-color 0.2s, transform 0.1s;
        }
        .btn:hover { transform: scale(1.05); }
        .btn-primary { background-color: var(--primary-color); color: white; }
        .btn-primary:hover { background-color: var(--primary-hover); }
        .btn-danger { background-color: var(--danger-color); color: white; }
        .btn-danger:hover { background-color: var(--danger-hover); }
        .btn-secondary { background-color: #d1d5db; color: #1f2937;}
        .btn-secondary:hover { background-color: #9ca3af; }

        /* ------- FORMULAIRE COULISSANT ------- */
        #side-form-container {
            position: fixed;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            pointer-events: none; /* Laisse passer les clics quand le fond est visible */
            z-index: 200;
        }
        #side-form-container.active { pointer-events: auto; } /* Capture les clics quand le fond est visible et le form ouvert */
        #form-overlay {

            position: absolute;
            background-color: red;
            color: white;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }
        #side-form-container.active #form-overlay { opacity: 1; }

        #side-form {
            position: absolute;
            top: 0; right: 0;
            width: 90%; max-width: 450px; height: 100%;
            background-color: white;
            box-shadow: -10px 0 20px rgba(0,0,0,0.1);
            padding: 2rem;
            transform: translateX(100%);
            transition: transform 0.3s ease-in-out;
            z-index: 101;
            display: flex; flex-direction: column;
        }
        #side-form-container.active #side-form { transform: translateX(0); }

        #close-form-btn {
            position: absolute; top: 5%; left: -35px; transform: translateY(-50%);
            width: 50px; height: 60px;
            z-index: 1;
            background: red; border: none;
            color: white;
            border-radius: 50px 0 0 50px;
            box-shadow: -5px 0 10px rgba(0,0,0,0.1); cursor: pointer;
            display: flex; align-items: center; justify-content: center;
        }
        .form-content { flex-grow: 1; }
        .form-content h2 { font-size: 1.5rem; margin-top: 0; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; font-weight: 500; margin-bottom: 0.5rem; }
        .form-group input { width: 100%; box-sizing: border-box; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; }
        .form-actions { display: flex; justify-content: flex-end; gap: 1rem; }


        /* ------- MODAL DE SUPPRESSION ------- */
        #delete-modal {
            position: fixed; inset: 0; background-color: rgba(0,0,0,0.6);
            display: none; align-items: center; justify-content: center; z-index: 200;
        }
        #delete-modal.active { display: flex; }
        .modal-content {
            background-color: white; padding: 2rem; border-radius: 0.5rem;
            width: 90%; max-width: 500px;
        }

        /* ------- TOASTER / NOTIFICATIONS ------- */
        #toaster-container {
            position: fixed; top: 20px; right: 20px; z-index: 9999;
        }
        .toast {
            background-color: var(--success-color); color: white;
            padding: 1rem 1.5rem; margin-bottom: 1rem;
            border-radius: 0.5rem; box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            animation: slideIn 0.3s ease forwards, fadeOut 0.5s ease 3s forwards;
        }
        @keyframes slideIn { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }
        @keyframes fadeOut { from { opacity: 1; } to { opacity: 0; transform: translateY(20px); } }

    </style>
</head>
<body>

<div class="container">
    <!-- HEADER -->
    <header>
        <h1>Gestion Clients</h1>
        <button onclick="openForm(null)" class="btn btn-primary">Ajouter un Client</button>
    </header>

    <!-- TABLEAU DES CLIENTS -->
    <div class="table-container">
        <table>
            <thead>
            <tr><th>ID</th><th>Nom</th><th>Email</th><th style="text-align: right; padding-right: 2rem;">Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach var="client" items="${clients}">
                <tr>
                    <td><c:out value="${client.id}"/></td>
                    <td><c:out value="${client.nom}"/></td>
                    <td><c:out value="${client.email}"/></td>
                    <td style="text-align: right;">
                        <div style="display: flex; gap: 0.5rem; justify-content: flex-end;">
                            <a href="<c:url value='/clients?action=modifier&id=${client.id}'/>" class="btn btn-primary" style="background-color: #4f46e5;">Modifier</a>
                            <button onclick="openDeleteModal(${client.id}, '${client.nom}')" class="btn btn-danger">Supprimer</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty clients}">
                <tr><td colspan="4" style="text-align: center; padding: 3rem; color: #6b7280;">Aucun client trouvé.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- PANNEAU COULISSANT -->
<div id="side-form-container">
    <div id="form-overlay" onclick="closeForm()"></div>
    <aside id="side-form">
        <button id="close-form-btn" onclick="closeForm()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
        </button>
        <div class="form-content">
            <h2 id="form-title"></h2>
            <form id="client-form" action="<c:url value='/clients'/>" method="post">
                <input type="hidden" id="form-action" name="action">
                <input type="hidden" id="client-id" name="id">

                <div class="form-group">
                    <label for="nom">Nom</label>
                    <input type="text" id="nom" name="nom" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-actions">
                    <button type="button" onclick="closeForm()" class="btn btn-secondary">Annuler</button>
                    <button type="submit" id="submit-button" class="btn"></button>
                </div>
            </form>
        </div>
    </aside>
</div>

<!-- MODAL DE SUPPRESSION -->
<div id="delete-modal">
    <div class="modal-content">
        <h3 style="font-size: 1.25rem; font-weight:600; margin-top:0;">Confirmer la Suppression</h3>
        <p id="delete-message" style="margin: 1.5rem 0;"></p>
        <form action="<c:url value='/clients'/>" method="post">
            <input type="hidden" name="action" value="supprimer">
            <input type="hidden" id="clientIdToDelete" name="clientIdToDelete">
            <div style="display: flex; justify-content: flex-end; gap: 1rem;">
                <button type="button" onclick="closeDeleteModal()" class="btn btn-secondary">Annuler</button>
                <button type="submit" class="btn btn-danger">Confirmer la Suppression</button>
            </div>
        </form>
    </div>
</div>

<!-- CONTENEUR POUR LES NOTIFICATIONS -->
<div id="toaster-container"></div>


<script>
    // === DOM ELEMENTS ===
    const body = document.body;
    const sideFormContainer = document.getElementById('side-form-container');
    const formTitle = document.getElementById('form-title');
    const clientForm = document.getElementById('client-form');
    const formAction = document.getElementById('form-action');
    const clientIdInput = document.getElementById('client-id');
    const clientNomInput = document.getElementById('nom');
    const clientEmailInput = document.getElementById('email');
    const submitButton = document.getElementById('submit-button');
    const deleteModal = document.getElementById('delete-modal');
    const clientIdToDeleteInput = document.getElementById('clientIdToDelete');
    const deleteMessage = document.getElementById('delete-message');

    // === FORM LOGIC ===
    function openForm(clientToEdit) {
        clientForm.reset();
        if (clientToEdit) { // Mode Modification
            formTitle.textContent = 'Modifier le Client';
            formAction.value = 'modifier';
            submitButton.textContent = 'Mettre à jour';
            submitButton.className = 'btn btn-primary';

            clientIdInput.value = clientToEdit.id;
            clientNomInput.value = clientToEdit.nom;
            clientEmailInput.value = clientToEdit.email;
        } else { // Mode Ajout
            formTitle.textContent = 'Ajouter un Client';
            formAction.value = 'ajouter';
            submitButton.textContent = 'Ajouter';
            submitButton.className = 'btn';
            submitButton.style.backgroundColor = 'var(--success-color)';
            submitButton.style.color = 'white';
            clientIdInput.value = '';
        }
        sideFormContainer.classList.add('active');
        body.classList.add('form-open');
    }

    function closeForm() {
        sideFormContainer.classList.remove('active');
        body.classList.remove('form-open');
    }

    // === MODAL LOGIC ===
    function openDeleteModal(id, nom) {
        clientIdToDeleteInput.value = id;
        deleteMessage.textContent = `Êtes-vous sûr de vouloir supprimer le client "${nom}" ? Cette action est irréversible.`;
        deleteModal.classList.add('active');
        body.classList.add('modal-open');
    }

    function closeDeleteModal() {
        deleteModal.classList.remove('active');
        body.classList.remove('modal-open');
    }

    // === TOASTER LOGIC ===
    function showToast(message) {
        const container = document.getElementById('toaster-container');
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = message;
        container.appendChild(toast);

        // L'animation CSS gère la suppression visuelle, on retire l'élément du DOM après.
        setTimeout(() => {
            toast.remove();
        }, 3500); // 3000ms de fadeout + 500ms de marge
    }

    // === INITIALISATION AU CHARGEMENT DE LA PAGE ===
    document.addEventListener('DOMContentLoaded', () => {
        // Logique pour pré-ouvrir le formulaire en mode modification si nécessaire
        <c:if test="${not empty clientAModifier}">
        openForm({
            id: '<c:out value="${clientAModifier.id}"/>',
            nom: '<c:out value="${clientAModifier.nom}"/>',
            email: '<c:out value="${clientAModifier.email}"/>'
        });
        </c:if>

        // Logique pour afficher le message Toaster si présent
        <c:if test="${not empty toastMessage}">
        showToast('${toastMessage}');
        </c:if>
    });

</script>
</body>
</html>