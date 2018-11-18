<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .modal {
        position: fixed;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 9;
        display: flex !important;
        justify-content: center;
        align-items: center;
        background-color: rgba(0, 0, 0, .7);
        height: 0;
    }

    #message-modal {
        /* animation-name: fadeIn;
        animation-fill-mode: forwards; */
        animation-timing-function: ease-in-out;
        animation-duration: 350ms;
    }

    .message-modal-title {
        font-size: 17px;
        border-radius: 5px 5px 0 0;
        background-color: #0084ff;
        color: white;
        padding: 20px 30px;
        position: relative;
        font-weight: bold;
    }

    .message-modal {
        background-color: #fff;
        border-radius: 0 0 4px 4px;
        color: #000;
        display: grid;
        grid-template-columns: 1fr;
        grid-auto-rows: max-content;
        row-gap: 10px;
        grid-row-gap: 10px;
        padding: 20px 30px;
        overflow-y: auto;
        align-self: center;
        margin-top: auto;
        margin-bottom: auto;
    }

    .message-modal-body {
        grid-column: 1/span 1;
    }

    .message-modal-footer {
        grid-column: 1/span 1;
        display: grid;
        grid-template-columns: max-content max-content;
        grid-template-rows: 100%;
        grid-column-gap: 10px;
        align-items: center;
        justify-content: flex-end;
    }

    .modal button {
        border: none;
        padding: 5px 15px;
        border-radius: 5px;
    }

    .modal button:nth-child(1) {
        background-color: #ab0800;
        color: white;
    }
</style>

<div class="modal">
    <div id="message-modal">
        <div class="message-modal-title">Delete Chapter</div>
        <div class="message-modal">
            <div class="message-modal-body">Are you sure you want to delete this chapter?</div>
            <div class="message-modal-footer">
                <button class="btn ld-ext-right">
                    OK  <div class="ld ld-ring ld-spin"></div>
                </button>
                <button>Cancel</button>
            </div>
        </div>
    </div>
</div>