var initSearch = function() {
    var lunrIndex = null;
    var lunrData = null;

    var makeSearch = function(query, callback) {
        var results = _(lunrIndex.search(query)).take(5).map(function(object) {
            entry = lunrData.docs[object.ref];
            entry["description"] = entry.tags;
            return entry;
        });
        
        callback({
            results: results
        });
    };

    var loadDataAndSearch = function(query, callback) {
        $.ajax({
            url: '/search.json',
            cache: true,
            method: 'GET',
            success: function(data) {
                lunrData = data;
                lunrIndex = lunr.Index.load(lunrData.index);
                makeSearch(query, callback);            
            }
        });
    };

    var executeSearch = function(settings, callback) {
        var query = $(this).find('input').val();
        if (lunrData == null) {
            loadDataAndSearch(query, callback);
        } else {
            makeSearch(query, callback);
        }
    };

    $('.ui.search').search({
        template  : 'standard',
        searchFields   : [
            'title',
            'tags'
        ],
        selectFirstResult: true,
        minCharacters: 2,
        maxResults: 5,
        apiSettings: {
            mockResponseAsync: executeSearch
        }
    });   

    loadDataAndSearch("", function(){});
};

$(document).ready(initSearch);
$(document).on('turbolinks:load', initSearch);
