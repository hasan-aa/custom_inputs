function clearEmptyValues() {
    console.log('custom_inputs.js : clearEmptyValues');
    document.querySelectorAll('.custom-inputs--input-field').forEach((input) => {
        if (!input.value) {
            input.setAttribute('disabled', 'disabled');
        }
    });
}

$(document).ready(function () {
    $('form').submit(clearEmptyValues);
});