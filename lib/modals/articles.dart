class Articles {
  Articles({required this.name, required this.authors, required this.link});
  final String name;
  final String authors;
  final String link;
}

List<Articles> listarticles = [
  Articles(
      name:
          "AI in Indian Libraries: Prospects and Perceptions from Library Professionals",
      authors: "A. Subaveerapandiyan, Alfian Akbar Gozali",
      link: "https://files.eric.ed.gov/fulltext/ED640098.pdf"),
  Articles(
      name:
          "EFL Students' Perception of Using AI Text-to-Speech Apps in Learning Pronunciation",
      authors: "Eman Abdel-Reheem Amin",
      link: "https://files.eric.ed.gov/fulltext/ED643603.pdf"),
  Articles(
      name:
          "The Educator's Lens: Understanding the Impact of AI on Management Education",
      authors: "Navita Vashista, Preeti Gugnani & Manju Bala",
      link: "https://files.eric.ed.gov/fulltext/EJ1413384.pdf"),
  Articles(
      name:
          "Towards Developing AI Literacy: Three Student Provocations on AI in Higher Education",
      authors:
          "Mavis Brew, Stephen Taylor, Rachel Lam, Leo Havemann, Chrissi Nerantzi",
      link: "https://files.eric.ed.gov/fulltext/EJ1410140.pdf")
];
