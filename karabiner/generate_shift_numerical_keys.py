from pydantic import BaseModel, Field, json
import json
import string


class DeviceIdentifier(BaseModel):
    vendor_id: int
    product_id: int
    description: str


class DeviceIfCondition(BaseModel):
    type_: str = "device_if"
    identifiers: list[DeviceIdentifier]
    
    class Config:
        fields = {
            'type_': 'type',
        }


class Modifiers(BaseModel):
    optional: list[str] | None = None
    mandatory: list[str] | None = None


class Key(BaseModel):
    key_code: str
    modifiers: Modifiers | list[str] | None = None


class Manipulator(BaseModel):
    type_: str
    from_: Key
    to: list[Key]
    conditions: list[DeviceIfCondition] | None = None

    class Config:
        fields = {
            'from_': 'from',
            'type_': 'type'
        }


class Rule(BaseModel):
    description: str
    manipulators: list[Manipulator]


class ComplexModifications(BaseModel):
    title: str
    rules: list[Rule]


def generate_reverse_numerical_keys_manipulators(device: DeviceIdentifier) -> list[Manipulator]:
    device_condition = DeviceIfCondition(identifiers=[device])
    manipulators = []
    for key_code in string.digits:
        manipulators.append(Manipulator(**{'type': "basic", 'from': Key(key_code=key_code, modifiers=from_shift), 'to': [Key(key_code=key_code)]}, conditions=[device_condition]))
    return manipulators 


def generate_keys_on_numerical_manipulators(device: DeviceIdentifier) -> list[Manipulator]:
    device_condition = DeviceIfCondition(identifiers=[device])
    manipulators = [
        Manipulator(**{'type': "basic", 'from': Key(key_code='1'), 'to': [Key(key_code="open_bracket")]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='2'), 'to': [Key(key_code="open_bracket", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='3'), 'to': [Key(key_code='9', modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='4'), 'to': [Key(key_code='4', modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='5'), 'to': [Key(key_code='7', modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='6'), 'to': [Key(key_code='equal_sign')]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='7'), 'to': [Key(key_code='hyphen', modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='8'), 'to': [Key(key_code='0', modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='9'), 'to': [Key(key_code="close_bracket", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='0'), 'to': [Key(key_code="close_bracket")]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='semicolon'), 'to': [Key(key_code="semicolon", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='semicolon', modifiers=from_shift), 'to': [Key(key_code="semicolon")]}, conditions=[device_condition]),

        Manipulator(**{'type': "basic", 'from': Key(key_code='open_bracket'), 'to': [Key(key_code="1", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='open_bracket', modifiers=from_shift), 'to': [Key(key_code="5", modifiers=["shift"])]}, conditions=[device_condition]),

        Manipulator(**{'type': "basic", 'from': Key(key_code='close_bracket'), 'to': [Key(key_code="2", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='close_bracket', modifiers=from_shift), 'to': [Key(key_code="3", modifiers=["shift"])]}, conditions=[device_condition]),

        Manipulator(**{'type': "basic", 'from': Key(key_code='hyphen'), 'to': [Key(key_code="hyphen")]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='hyphen', modifiers=from_shift), 'to': [Key(key_code="8", modifiers=["shift"])]}, conditions=[device_condition]),

        Manipulator(**{'type': "basic", 'from': Key(key_code='equal_sign'), 'to': [Key(key_code="1", modifiers=["shift"])]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='equal_sign', modifiers=from_shift), 'to': [Key(key_code="equal_sign", modifiers=["shift"])]}, conditions=[device_condition]),

        Manipulator(**{'type': "basic", 'from': Key(key_code='left_control'), 'to': [Key(key_code="left_option")]}, conditions=[device_condition]),
        Manipulator(**{'type': "basic", 'from': Key(key_code='delete_forward'), 'to': [Key(key_code="tab")]}, conditions=[device_condition]),
        ]
    return manipulators

if __name__ == '__main__':
    kinesis = DeviceIdentifier(vendor_id=10730, product_id=864, description="Kinesis 360")
    # kinesis = DeviceIfCondition(identifiers=[DeviceIdentifier(vendor_id=10730, product_id=864, description="Kinesis 360")])
    from_shift = Modifiers(mandatory=["shift"])
    
    reverse_numerical_manipulators = generate_reverse_numerical_keys_manipulators(kinesis) 
    special_on_numerical_manipulators = generate_keys_on_numerical_manipulators(kinesis) 
    manipulators = reverse_numerical_manipulators + special_on_numerical_manipulators
    rule = Rule(description="Special on Numerical Keys", manipulators=manipulators)
    modification = ComplexModifications(title="Shift Numerical Keys", rules=[rule])
    text = modification.json(indent=2, by_alias=True, exclude_none=True)
    
    with open("shift_numerical_keys.json", "w") as f:
        json.dump(modification.dict(by_alias=True, exclude_none=True), f, indent=2, sort_keys=True)

