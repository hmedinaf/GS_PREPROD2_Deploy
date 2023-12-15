public class Person{
    private String name;
    private String motherMaidenName;
    private String lastName;
    private String gender;
    private Date birthDate;
    private String birthPlace;

    public Person setName(String name){
        this.name = formatInput(name);
        return this;
    }

    public Person setNameNoFormating(String name){
        this.name = name;
        return this;
    }

    public String getName(){
        return this.name;
    }

    public Person setMotherMaidenName(String motherMaidenName){
        this.motherMaidenName = this.formatInput(motherMaidenName);
        return this;
    }

    public String getMotherMaidenName(){
        return this.motherMaidenName;
    }

    public Person setLastName(String lastName){
        this.lastName = this.formatInput(lastName);
        return this;
    }

    public String getLastName(){
        return this.lastName;
    }

    public Person setGender(String gender){
        this.gender = gender;
        return this;
    }

    public String getGender(){
        return this.gender.toUpperCase();
    }

    public String getGenderCode(){
        if (this.gender == 'MASCULINO') {
            this.gender = 'H';
        } else if (this.gender == 'FEMENINO') {
            this.gender = 'M';
        } else {
            this.gender = 'X';
        }
        return this.gender;
    }

    public Person setBirthDate(Date birthDate){
        this.birthDate = birthDate;
        return this;
    }
    
    public Date getBirthDate(){
        return this.birthDate;
    }
    
    public Integer getBirthYear(){
        return this.birthDate.year();
    }
    
    public Integer getBirthMonth(){
        return this.birthDate.month();
    }
    
    public Integer getBirthDay(){
        return this.birthDate.day();
    }

    public Person setBirthPlace(String birthPlace){
        this.birthPlace = birthPlace.toUpperCase();
        return this;
    }

    public String getBirthPlace(){
        return this.birthPlace;
    }
    
    private String formatInput(String input){
        return new StringBuilder(input.toUpperCase())
            .replaceSpecialChars()
            .removePrepConjCont()
            .getString();
    }
}