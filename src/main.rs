use git2::Repository;

fn main() {
    // std::fs::create_dir_all("test").unwrap();
    Repository::clone("https://github.com/vbrandl/hoc", "test").unwrap();
    // let repo = Repository::init("test").unwrap();
    // repo.remote_add_fetch("origin", "refs/heads/*:refs/heads/*").unwrap();
    // repo.remote_set_url("origin", "https://github.com/vbrandl/hoc").unwrap();
    // let mut origin = repo.find_remote("origin").unwrap();
    // origin.fetch(&["refs/heads/*:refs/heads/*"], None, None).unwrap();
}
