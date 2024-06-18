def vowels_delete(text: str) -> str:
    VOWELS = "aeiouAEIOU"
    if not isinstance(text, str):
        raise TypeError("Input should be a string")
    if text == "":
        raise ValueError("Input should not be empty")
    return ''.join([i for i in text if i not in VOWELS])


def tests():
    result = 'All tests passed successfully.'
    try:
        assert vowels_delete("Hello, World!") == "Hll, Wrld!"
        assert vowels_delete("Python") == "Pythn"
        assert vowels_delete("AEIOU") == ""
        assert vowels_delete("aeiou") == ""
        assert vowels_delete("123456") == "123456"
        assert vowels_delete(" ") == " "
        assert vowels_delete("") == ValueError, "Input should not be empty"
        assert vowels_delete(123) == TypeError, "Input should be a string"
    except ValueError:
        pass
    except TypeError:
        pass
    except AssertionError as e:
        result = f'Test failed: {e}'
    print(result)


if __name__ == '__main__':
    # tests()
    input_text = str(input("Enter a string: "))
    print(vowels_delete(input_text))
