from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory storage
candidates = []
assessments = []

# Home page route
@app.route('/', methods=['GET'])
def home():
    return """
    <h1>Welcome to the Barkuni Candidate Assessment System</h1>
    <p>This is an API service for managing candidates and their skill assessments.</p>
    <h2>Available Endpoints:</h2>
    <ul>
        <li>POST /candidates - Create a new candidate</li>
        <li>GET /candidates - List all candidates</li>
        <li>POST /candidates/{id}/assess - Add an assessment for a candidate</li>
        <li>GET /candidates/{id}/assessments - Get all assessments for a candidate</li>
    </ul>
    """


# Helper function to find candidate by ID
def find_candidate(candidate_id):
    return next((c for c in candidates if c['id'] == candidate_id), None)

# Routes
@app.route('/candidates', methods=['POST'])
def create_candidate():
    data = request.get_json()
    
    candidate = {
        'id': len(candidates) + 1,
        'name': data['name'],
        'email': data['email']
    }
    
    candidates.append(candidate)
    return jsonify({'message': 'Candidate created', 'candidate': candidate}), 201

@app.route('/candidates', methods=['GET'])
def get_candidates():
    return jsonify(candidates)

@app.route('/candidates/<int:id>/assess', methods=['POST'])
def assess_candidate(id):
    candidate = find_candidate(id)
    if not candidate:
        return jsonify({'error': 'Candidate not found'}), 404
    
    data = request.get_json()
    assessment = {
        'id': len(assessments) + 1,
        'candidate_id': id,
        'skill': data['skill'],
        'score': data['score']
    }
    
    assessments.append(assessment)
    return jsonify({'message': 'Assessment added', 'assessment': assessment}), 201

@app.route('/candidates/<int:id>/assessments', methods=['GET'])
def get_candidate_assessments(id):
    candidate = find_candidate(id)
    if not candidate:
        return jsonify({'error': 'Candidate not found'}), 404
    
    candidate_assessments = [a for a in assessments if a['candidate_id'] == id]
    return jsonify(candidate_assessments)

@app.route('/health')
def health_check():
    return jsonify({"status": "healthy"}), 200

@app.route('/ready')
def ready_check():
    # Add any additional checks here to ensure your app is ready to serve traffic
    return jsonify({"status": "ready"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)