#!/usr/bin/env bash

new_list() {
    cat <<END | sqlite3 quotes.db
	CREATE TABLE $1 (
	    id INTERGER PRIMARY KEY,
	    quote TEXT,
	    who TEXT,
	    concept TEXT
    )
END
}

# Quote, speaker | character (writer), concept
add_quote() {
    if [ "$1" == 'i' ]; then
	quote=$(gum write --placeholder "Quote" | sed "s/'/''/g")
	who=$(gum input --placeholder "Who said this?" | sed "s/'/''/g")
	concept=$(gum input --placeholder "What concept does this cover?" | sed "s/'/''/g")

	cat <<END | sqlite3 quotes.db
	INSERT INTO serious (quote, who, concept) VALUES (
	    '$quote',
	    '$who',
	    '$concept'
	) 
END
else
    cat <<END | sqlite3 quotes.db
    INSERT INTO serious (quote, who, concept) VALUES ('$1', '$2', '$3')
    quote=$1
END
    fi
git commit -m "add quote: '$quote'"
}
