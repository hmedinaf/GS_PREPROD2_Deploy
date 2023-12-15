public class StringBuilder {
    private String input;

    public StringBuilder(String input){
        this.input = input;
    }

    public StringBuilder setString(String input){
        this.input = input;
        return this;
    }

    public String getString(){
        return input;
    }

    public StringBuilder replaceSpecialChars(){
        this.input = this.input.replaceAll('[ÀÁÂÃÄÅ]','A');
        this.input = this.input.replaceAll('[ÈÉÊË]','E');
        this.input = this.input.replaceAll('[ÌÍÎÏ]','I');
        this.input = this.input.replaceAll('[ÒÓÔÕÖØ]','O');
        this.input = this.input.replaceAll('[ÙÚÛÜ]','U');
        this.input = this.input.replaceAll('[Ç]','C');
        this.input = this.input.replaceAll('[ÿ]','Y');

        return this;
    }

    public StringBuilder removeInvalidWords(Set<String> invalidWords){
        return this;
    }

    public StringBuilder removePrepConjCont(){
        List<String> splitList = this.input.split(' ');
		
        if(splitList.size() <= 1){
            return this;
        }

        List<String> cleanedList = new List<String>();
        for(String s : splitList){
            if(!Constants.PREPS_CONJ_CONT.contains(s)){
                cleanedList.add(s);
            }
        }

        this.input = String.join(cleanedList,' ');
        return this;
    }
}