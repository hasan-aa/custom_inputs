class ArrayModifier {
    static removeFromArrayInput(e) {
        let button = this;
        let input = button.previousSibling;
        let undoable = button.classList.contains('undoable');

        if (undoable) {
            if (input.disabled) {
                button.innerHTML = `<i class="fa fa-minus-circle"></i>`;
                input.disabled = false;
                return input.classList.remove('text--strike');
            } else {
                button.innerHTML = `<i class="fa fa-undo"></i>`;
                input.disabled = true;
                input.classList.add('text--strike');
            }
        } else {
            button.parentElement.remove();
        }
    }

    static createNewInput(value) {
        let template = document.querySelector('.input-group--array__item.template');
        let clone = template.cloneNode(true);

        clone.classList.remove('template', 'hidden')

        let input = clone.querySelector('input');
        input.removeAttribute('disabled');
        input.value = value;
        input.focus();

        return clone;
    }

    static handleKeyDown(event) {
        if (event.key === 'Enter') {
            ArrayModifier.handleAddClick(event, this.nextSibling);
            return false;
        }
    }

    static handleAddClick(e, b) {
        e.preventDefault();

        let button = b || this;
        let newItemField = button.parentNode;
        let input = button.previousSibling;

        let value = input.value;
        if (value !== '') {
            input.value = '';
            let clone = ArrayModifier.createNewInput(value);
            newItemField.parentNode.insertBefore(clone, newItemField);
        } else {
            return input.focus();
        }
    }
}

$(document).ready(function () {
    $('.js-add-to-array-input').click(ArrayModifier.handleAddClick);

    let arrayInputContainer = $('.input-group--array');
    $(arrayInputContainer).on('click', '.js-remove-from-array-input', ArrayModifier.removeFromArrayInput);
    $(arrayInputContainer).on('keydown', '.input-group--array__item input', ArrayModifier.handleKeyDown)
});